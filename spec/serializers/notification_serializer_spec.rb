# == Schema Information
#
# Table name: notifications
#
#  id           :bigint(8)        not null, primary key
#  user_id      :bigint(8)
#  type         :string
#  response     :jsonb
#  object_type  :string
#  object_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  read_at      :datetime
#  responded_at :datetime
#
# Indexes
#
#  index_notifications_on_object_type_and_object_id  (object_type,object_id)
#  index_notifications_on_read_at                    (read_at)
#  index_notifications_on_type                       (type)
#  index_notifications_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe NotificationSerializer do
  subject { JSON.parse(NotificationSerializer.new(notification).to_json) }

  context 'share request notification' do
    let(:notification) { create(:share_request_notification) }
    let(:object) { BranchSerializer.new(notification.object) }

    it { expect(subject['id']).to eq(notification.id) }
    it { expect(subject['date']).to eq(notification.created_at.iso8601(3)) }
    it { expect(subject['type']).to eq('share_request') }
    it { expect(subject['object']).to eq(JSON.parse(object.to_json)) }
  end

  context 'rating request notification' do
    let(:notification) { create(:rating_request_notification) }
    let(:object) { BranchSerializer.new(notification.object) }

    it { expect(subject['id']).to eq(notification.id) }
    it { expect(subject['date']).to eq(notification.created_at.iso8601(3)) }
    it { expect(subject['type']).to eq('rating_request') }
    it { expect(subject['object']).to eq(JSON.parse(object.to_json)) }
  end
end
