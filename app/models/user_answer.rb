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

class UserAnswer < ApplicationRecord
  has_paper_trail only: %i[values note], class_name: 'Versions::UserAnswerVersion'

  serialize :values

  belongs_to :question
  belongs_to :user

  validates :user, :question, presence: true
  validates :values, presence: true, unless: :text?
  validates :question_id, uniqueness: { scope: :user_id }
  validate :values_format

  delegate :kind, to: :question, allow_nil: true

  Question::KINDS.each do |kind_name|
    define_method("#{kind_name}?") { kind == kind_name }
  end

  private

  def values_format
    return unless values.present?
    case kind
    when 'ordered_list', 'unordered_list'
      return if values.is_a?(Array)
    when 'text'
      # NB: just check that we have a single answer object
      return unless values.is_a?(Array) || values.is_a?(Range)
    when 'option', 'boolean'
      return if values.is_a?(String) || values.is_a?(Numeric)
    when 'number'
      # TODO: allow adding "Don't mind" as an answer
      return if values.is_a?(Numeric)
    when 'time'
      return if values.try(:to_time).is_a?(Time)
    when 'number_range', 'time_range'
      # TODO: implement range type in frontend
      return if values.is_a?(Array) || values.is_a?(Range) # && values.any?
    end
    errors.add(:values, 'are invalid')
  end
end
