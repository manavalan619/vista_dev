# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#
# Indexes
#
#  index_cities_on_status  (status)
#

require 'rails_helper'

RSpec.describe City, type: :model do
  subject { build(:city) }

  describe 'associations' do
    it { is_expected.to have_one(:photo) }
    it { is_expected.to accept_nested_attributes_for(:photo) }
  end

  describe 'validatations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:photo) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(City::STATUSES) }
  end
end
