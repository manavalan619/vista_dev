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

class Organisation < ApplicationRecord
  acts_as_paranoid column: :archived_at

  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
  has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner
  has_many :staff_members, dependent: :destroy
  has_many :branch_managers, dependent: :destroy
  has_many :admins, dependent: :destroy
  has_many :business_units, dependent: :destroy
  has_many :branches, through: :business_units
  has_many :roles, through: :business_units
  has_many :videos

  validates :name, presence: true

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :photo, reject_if: :reject_photo?, allow_destroy: true

  private

  def reject_photo?(attributes)
    attributes['image'].blank?
  end
end
