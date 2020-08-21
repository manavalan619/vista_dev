require 'rails_helper'

describe Share::RevokeAll do
  subject { described_class.call(user) }
  before { 3.times { create(:share, :authorised, user: user) } }
  let!(:user) { create(:user) }

  describe 'call' do
    context 'successful' do
      it { expect { subject }.to change { Share.revoked.count }.by(3) }
      it { is_expected.to be_success }
    end

    context 'not successful' do
      before do
        allow(user).to receive_message_chain(:shares, :revoke_all).and_return(false)
        allow(user).to receive(:errors).and_return([nil])
      end

      it { is_expected.to be_failure }
    end
  end
end
