# == Schema Information
#
# Table name: user_answers
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  note        :text
#  values      :text
#
# Indexes
#
#  index_user_answers_on_question_id  (question_id)
#  index_user_answers_on_user_id      (user_id)
#

class UserAnswerSerializer < ActiveModel::Serializer
  attributes :id, :question_id, :values, :note, :synced, :created_at, :updated_at
  attribute :errors, if: :errors_present?

  def synced
    true
  end

  def errors_present?
    object.errors.present?
  end
end
