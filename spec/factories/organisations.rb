# == Schema Information
#
# Table name: organisations
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  about       :text
#  archived_at :datetime
#

FactoryBot.define do
  factory :organisation do
    name { Faker::Company.name }

    before(:create) do |organisation|
      organisation.address = build(:address, addressable: organisation)
    end
  end
end
