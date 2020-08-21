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

FactoryBot.define do
  factory :user_answer do
    association :user
    association :question, factory: %i[question text]
    values { 'test' }
    note { Faker::Lorem.sentence }
  end
end
