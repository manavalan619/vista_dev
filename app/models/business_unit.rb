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

class BusinessUnit < ApplicationRecord
  acts_as_paranoid column: :archived_at

  belongs_to :organisation
  has_many :branches, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :member_request_types

  validates :name, presence: true
  validates :organisation, presence: true
end
