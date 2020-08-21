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

require 'rails_helper'

RSpec.describe Organisation, type: :model do
  subject { build(:organisation) }

  describe 'associations' do
    it { is_expected.to have_one(:address) }
    it { is_expected.to have_one(:photo) }
  end

  describe 'validatations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  it { is_expected.to accept_nested_attributes_for(:address) }
end
