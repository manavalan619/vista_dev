# == Schema Information
#
# Table name: business_units
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  organisation_id :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archived_at     :datetime
#
# Indexes
#
#  index_business_units_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#

FactoryBot.define do
  factory :business_unit do
    name         { Faker::Company.name }
    organisation
  end
end
