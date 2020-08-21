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

require 'rails_helper'

RSpec.describe Address, type: :model do
  subject { build(:address) }

  describe 'associations' do
    it { is_expected.to belong_to(:addressable) }
    it { is_expected.to belong_to(:city) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to_not validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:line1) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:county) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:postcode) }
    it { is_expected.to validate_presence_of(:addressable) }
  end
end
