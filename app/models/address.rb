# == Schema Information
#
# Table name: addresses
#
#  id               :bigint(8)        not null, primary key
#  label            :string
#  line1            :string
#  line2            :string
#  town             :string
#  county           :string
#  postcode         :string
#  country          :string
#  phone            :string
#  latitude         :decimal(10, 6)
#  longitude        :decimal(10, 6)
#  addressable_type :string
#  addressable_id   :bigint(8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  city_id          :bigint(8)
#
# Indexes
#
#  index_addresses_on_addressable_type_and_addressable_id  (addressable_type,addressable_id)
#  index_addresses_on_city_id                              (city_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, inverse_of: :address
  belongs_to :city

  acts_as_mappable lat_column_name: :latitude,
                   lng_column_name: :longitude

  validates :line1, :county, :postcode, :country, :latitude, :longitude,
            presence: true
  validates :addressable, presence: true
  validates :city, presence: true

  def country_name
    code = read_attribute(:country)
    return nil unless code.present?
    c = ISO3166::Country[code]
    c.translations[I18n.locale.to_s] || c.name
  rescue
    super
  end

  def country_code
    read_attribute(:country)
  end
end
