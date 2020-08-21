# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#
# Indexes
#
#  index_cities_on_status  (status)
#

FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    photo
    status { 'enabled' }
  end
end
