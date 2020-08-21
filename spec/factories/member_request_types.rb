# == Schema Information
#
# Table name: member_request_types
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  business_unit_id :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  archived_at      :datetime
#
# Indexes
#
#  index_member_request_types_on_business_unit_id  (business_unit_id)
#

FactoryBot.define do
  factory :member_request_type do
    business_unit
    name { Faker::Job.field }
  end
end
