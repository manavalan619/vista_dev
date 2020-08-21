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

FactoryBot.define do
  factory :category do
    title { Faker::Job.field }
    description { Faker::Lorem.paragraph }

    factory :nested_category do
      association :parent, factory: :category
    end
  end
end
