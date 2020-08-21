# == Schema Information
#
# Table name: content_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :content_category do
    name { Faker::Lorem.words(3) }
  end
end
