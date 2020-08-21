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

require 'rails_helper'

RSpec.describe BusinessUnit, type: :model do
  subject { build(:business_unit) }

  describe 'associations' do
    it { is_expected.to belong_to(:organisation) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:organisation) }
  end
end
