# == Schema Information
#
# Table name: devices
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  platform   :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_devices_on_platform  (platform)
#  index_devices_on_token     (token)
#  index_devices_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  subject { build(:device) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :platform }
  it { is_expected.to validate_presence_of :token }
end
