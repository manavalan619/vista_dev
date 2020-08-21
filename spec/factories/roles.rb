# == Schema Information
#
# Table name: roles
#
#  id                 :bigint(8)        not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  archived_at        :datetime
#  business_unit_id   :bigint(8)
#  top_questions_data :jsonb
#  interactions       :string           is an Array
#
# Indexes
#
#  index_roles_on_business_unit_id  (business_unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_unit_id => business_units.id)
#

FactoryBot.define do
  factory :role do
    business_unit
    name { Faker::Job.field }
  end
end
