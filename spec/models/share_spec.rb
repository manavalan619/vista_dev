# == Schema Information
#
# Table name: shares
#
#  id            :bigint(8)        not null, primary key
#  branch_id     :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string
#  via           :string
#  requested_at  :datetime
#  authorised_at :datetime
#  denied_at     :datetime
#  revoked_at    :datetime
#
# Indexes
#
#  index_shares_on_status  (status)
#  index_shares_on_via     (via)
#

require 'rails_helper'

RSpec.describe Share, type: :model do
  subject { build(:share) }
  let(:share_request_notification) do
    build(:share_request_notification, object: subject.branch, user: subject.user)
  end

  describe 'associations' do
    it { is_expected.to belong_to(:branch) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'callbacks' do
    it 'receives create_request_notification after request' do
      expect(subject).to receive(:create_request_notification)
      subject.request!
    end

    describe 'create_request_notification' do
      it 'creates a notification with branch and user' do
        expect { subject.request! }.to change {
          Notification::ShareRequest.where(
            object: subject.branch, user: subject.user
          ).count
        }.by(1)
      end
    end
  end

  describe 'authorise!' do
    subject { build(:share, :requested) }
    before { share_request_notification.save }

    it 'updates notifications' do
      subject.authorise!
      expect(share_request_notification.reload.response).to eq 'authorised'
    end
  end

  describe 'deny!' do
    subject { build(:share, :requested) }
    before { share_request_notification.save }

    it 'updates notifications' do
      subject.deny!
      expect(share_request_notification.reload.response).to eq 'denied'
    end
  end
end
