# == Schema Information
#
# Table name: categories
#
#  id                      :bigint(8)        not null, primary key
#  title                   :citext
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  ancestry                :string
#  description             :text
#  position                :integer          default(0), not null
#  initial                 :boolean          default(FALSE)
#  visibility_conditions   :jsonb            not null
#  text_style              :string           default("dark")
#  subtree_questions_count :integer          default(0)
#  questions_count         :integer          default(0)
#
# Indexes
#
#  index_categories_on_ancestry               (ancestry)
#  index_categories_on_ancestry_and_position  (ancestry,position)
#

class Category < ApplicationRecord
  TEXT_STYLES = %w[dark light].freeze
  # :destroy   All children are destroyed as well (default)
  # :rootify   The children of the destroyed node become root nodes
  # :restrict  An AncestryException is raised if any children exist
  # :adopt     The orphan subtree is added to the parent of the deleted node.
  #            If the deleted node is Root, then rootify the orphan subtree.
  has_ancestry orphan_strategy: :destroy, touch: true

  has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner
  has_many :questions, dependent: :destroy
  has_many :ignores, dependent: :destroy
  has_many :category_updates, dependent: :destroy

  accepts_nested_attributes_for :photo, reject_if: :reject_photos?

  default_scope -> { reorder(position: :asc) }
  scope :with_questions, -> { where.not(questions_count: 0) }

  before_validation :check_valid_initial
  before_create :set_position
  before_save :set_initial
  after_commit :update_position, on: :create
  after_commit :update_initial

  validates :title, presence: true

  cache_warm_attributes :visibility_conditions_tree, :descendants_count,
                        :subtree_questions_count, :title_with_nesting

  def to_s
    title
  end

  def visibility_conditions=(new_visibility_conditions)
    return super([]) unless new_visibility_conditions
    super(new_visibility_conditions.map do |condition|
      new_con = condition.dup.with_indifferent_access
      new_con[:question_id] = new_con[:question_id].to_i
      new_con
    end)
  end

  def visibility_conditions_tree
    Rails.cache.fetch [self, :visibility_conditions_tree] do
      ancestors.flat_map do |a|
        a.visibility_conditions.map { |c| c.merge(type: 'inherited') }
      end.push(visibility_conditions.map { |c| c.merge(type: 'own') }).flatten
    end
  end

  def descendants_count
    Rails.cache.fetch [self, :descendants_count] do
      descendants.count
    end
  end

  # def subtree_questions_count
  #   Rails.cache.fetch [self, :subtree_questions_count] do
  #     Question.where(category_id: subtree_ids).count
  #   end
  # end

  def title_with_nesting
    Rails.cache.fetch [self, :title_with_nesting] do
      [ancestors, self].flatten.map(&:title).join('/')
    end
  end

  def children?
    Rails.cache.fetch [self, :has_children] do
      has_children?
    end
  end

  def answered_questions_count(user)
    Rails.cache.fetch [self, :answered_questions_count, user] do
      question_ids = Question.where(category_id: subtree_ids).pluck(:id)

      UserAnswer.where(
        question_id: question_ids,
        user_id: user.id
      ).count
    end
  end

  private

  def reject_photos?(attributes)
    attributes['image'].blank? && attributes['remote_image_url'].blank?
  end

  def check_valid_initial
    return unless initial?
    self.initial = false unless ancestry.blank?
  end

  def set_position
    return if position.present?
    self.position = (siblings.maximum(:position) || 0) + 1
  end

  def update_position
    only_siblings = siblings.where.not(id: id).where('position >= ?', position)
    Category.transaction do
      only_siblings.each { |c| Category.increment_counter(:position, c.id) }
    end
  end

  def set_initial
    return if initial?
    return if Category.roots.where(initial: true).exists?
    self.initial = true
  end

  def update_initial
    return unless initial?
    siblings.where.not(id: id).update_all(initial: false)
  end

  def increment_question_counter
    [self, ancestors].flatten.each do |category|
      category.increment!(:subtree_questions_count)
    end
  end

  def decrement_question_counter
    [self, ancestors].flatten.each do |category|
      category.decrement!(:subtree_questions_count)
    end
  end
end
