# == Schema Information
#
# Table name: partners
#
#  id              :integer          not null, primary key
#  organisation_id :integer
#  first_name      :string
#  last_name       :string
#  mobile_number   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_partners_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#

class PartnerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :mobile_number
  attribute :errors, if: :errors_present?

  has_one :user
  has_many :photos

  def errors_present?
    object.errors.present?
  end
end
