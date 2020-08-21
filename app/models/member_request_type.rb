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

class MemberRequestType < ApplicationRecord
  acts_as_paranoid column: :archived_at
  belongs_to :business_unit
  has_one :organisation, through: :business_unit
  has_many :member_request_type_assignments
  has_many :roles, through: :member_request_type_assignments
  has_many :staff_members, through: :roles

  validates :name, presence: true
end
