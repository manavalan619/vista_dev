# == Schema Information
#
# Table name: branches
#
#  id               :bigint(8)        not null, primary key
#  business_unit_id :bigint(8)
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string
#  telephone        :string
#  archived_at      :datetime
#  image            :string
#  branch_info      :string
#  booking_url      :string
#  vista_partner    :boolean          default(FALSE)
#  ratings_count    :integer          default(0)
#
# Indexes
#
#  index_branches_on_business_unit_id  (business_unit_id)
#  index_branches_on_vista_partner     (vista_partner)
#
# Foreign Keys
#
#  fk_rails_...  (business_unit_id => business_units.id)
#

require 'rails_helper'

RSpec.describe Branch, type: :model do
  subject { build(:branch) }

  describe 'associations' do
    it { is_expected.to belong_to(:business_unit) }
  end

  describe 'validations' do
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:business_unit) }
  end
end
