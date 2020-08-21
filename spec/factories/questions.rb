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

FactoryBot.define do
  factory :question do
    association :category
    title { Faker::Lorem.sentence + '?' }
    transient do
      answers_count { 2 }
    end

    after(:build) do |question, evaluator|
      question.answers_attributes = attributes_for_list(:answer, evaluator.answers_count)
    end

    trait :text do
      kind { 'text' }
    end

    trait :number do
      kind { 'number' }
    end

    trait :number_range do
      kind { 'number_range' }
    end

    trait :time do
      kind { 'time' }
    end

    trait :time_range do
      kind { 'time_range' }
    end

    trait :option do
      kind { 'option' }
    end

    trait :unordered_list do
      kind { 'unordered_list' }
    end

    trait :ordered_list do
      kind { 'ordered_list' }
    end

    trait :boolean do
      kind { 'boolean' }
    end

    trait :temperature do
      kind { 'temperature' }
    end

    trait :temperature_range do
      kind { 'temperature_range' }
    end
  end
end
