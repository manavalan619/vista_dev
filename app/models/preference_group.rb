# == Schema Information
#
# Table name: preference_groups
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  question_ids :integer          default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_preference_groups_on_question_ids  (question_ids) USING gin
#

class PreferenceGroup < ApplicationRecord
  has_many :role_preference_group_assignments

  validates :title, presence: true
  validates :question_ids, presence: true

  def question_ids=(new_ids)
    super(new_ids.reject(&:blank?))
  end

  def questions
    Question.where(id: question_ids)
  end
end
