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

FactoryBot.define do
  factory :device do
    user
    platform { 'ios' }
    token { SecureRandom.uuid }

    trait :android do
      platform { 'android' }
    end
  end
end
