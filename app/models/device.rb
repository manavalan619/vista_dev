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

class Device < ApplicationRecord
  belongs_to :user

  validates :user, :token, :platform, presence: true

  after_commit :remove_previous, on: :create

  %w[ios android].each do |platform_name|
    define_method("#{platform_name}?") { platform == platform_name }
  end

  private

  # NB: if another user signs in on a previous device, remove previous user
  def remove_previous
    Device.where(token: token).where.not(user: user).destroy_all
  end
end
