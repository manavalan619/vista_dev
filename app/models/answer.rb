# == Schema Information
#
# Table name: answers
#
#  id          :bigint(8)        not null, primary key
#  question_id :bigint(8)
#  title       :citext
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position    :integer          default(0)
#
# Indexes
#
#  index_answers_on_position     (position)
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

class Answer < ApplicationRecord
  has_paper_trail only: %i[title description], class_name: 'Versions::AnswerVersion'

  belongs_to :question, inverse_of: :answers

  has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner

  accepts_nested_attributes_for :photo, reject_if: :reject_photo?, allow_destroy: true

  after_initialize :set_position

  validates :title, :question, presence: true

  default_scope -> { order(position: :asc) }

  clean_attributes :title

  def siblings
    # NB: use reject to allow unsaved siblings to be loaded from memory
    question.answers.reject { |s| s == self }
  end

  private

  def reject_photo?(attributes)
    attributes['image'].blank?
  end

  def set_position
    return if position.positive?
    self.position = (siblings.max_by(&:position).try(:position) || 0) + 1
  end
end
