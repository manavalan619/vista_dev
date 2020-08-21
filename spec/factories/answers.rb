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

FactoryBot.define do
  factory :answer do
    association :question, :text
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }

    initialize_with { new(attributes) }
  end
end
