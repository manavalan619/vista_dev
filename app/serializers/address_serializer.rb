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

class AddressSerializer < ApplicationSerializer
  attributes :id, :label, :line1, :line2, :city, :county, :postcode, :country,
             :phone, :latitude, :longitude

  def city
    object.city.try(:name)
  end
end
