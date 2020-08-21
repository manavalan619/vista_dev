# == Schema Information
#
# Table name: questions
#
#  id                 :bigint(8)        not null, primary key
#  category_id        :integer
#  title              :citext
#  kind               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  locking_conditions :jsonb            not null
#  intro              :boolean          default(FALSE)
#  allows_note        :boolean          default(TRUE)
#  note_title         :string
#  processed_at       :datetime
#  text_style         :string           default("dark")
#  blur_background    :boolean          default(FALSE)
#  background_overlay :boolean          default(FALSE)
#
# Indexes
#
#  index_questions_on_allows_note   (allows_note)
#  index_questions_on_category_id   (category_id)
#  index_questions_on_intro         (intro)
#  index_questions_on_kind          (kind)
#  index_questions_on_processed_at  (processed_at)
#

class Question < ApplicationRecord
  ENUMERABLE_KINDS = %w[
    option unordered_list ordered_list boolean number number_range
    temperature temperature_range
  ].freeze
  DIVERSE_KINDS = %w[text time time_range].freeze
  KINDS = ENUMERABLE_KINDS + DIVERSE_KINDS
  TRACKABLE_ATTRS = %i[
    title kind locking_conditions intro allows_note note_title category_id
  ].freeze
  TEXT_STYLES = %w[dark light dark-gold light-gold].freeze

  has_paper_trail only: TRACKABLE_ATTRS, class_name: 'Versions::QuestionVersion'

  belongs_to :category, touch: true, counter_cache: true

  has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner
  has_many :answers, dependent: :destroy, inverse_of: :question
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :photo, reject_if: :reject_photo?, allow_destroy: true
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  validates :category, :title, :kind, presence: true
  validates :kind, inclusion: { in: KINDS, message: '%{value} is not a valid kind' }
  validates :text_style, inclusion: {
    in: TEXT_STYLES, message: "must be one of: '#{TEXT_STYLES.join(', ')}'",
    allow_blank: true
  }
  validate :answers?, if: :enumerable_kind?

  scope :in_category, ->(category) { where(category_id: category) }
  scope :of_kind, ->(kind) { where(kind: kind) }
  scope :intro, ->(intro) { where(intro: intro) }
  scope :search, ->(term) { where('questions.title ILIKE ?', "%#{term}%") }
  scope :unprocessed, -> { where(processed_at: nil) }

  after_commit :increment_category_counters, on: :create
  after_commit :decrement_category_counters, on: :destroy

  clean_attributes :title

  def enumerable_kind?
    ENUMERABLE_KINDS.include?(kind)
  end

  def diverse_kind?
    DIVERSE_KINDS.include?(kind)
  end

  private

  def answers?
    return if answers.size > 1
    errors.add(:answers, 'multiple answers needed')
  end

  def reject_photo?(attributes)
    attributes['image'].blank? && attributes['remote_image_url'].blank?
  end

  def increment_category_counters
    # Yeh I know, private...
    category.send(:increment_question_counter)
  end

  def decrement_category_counters
    # Yeh I know, private...
    category.send(:decrement_question_counter)
  end
end
