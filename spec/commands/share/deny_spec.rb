require 'rails_helper'

describe Share::Deny do
  let(:branch) { create(:branch) }
  let(:user) { create(:user) }
  let(:params) { { branch: branch, user: user } }
  let!(:share) { create(:share, :requested, branch: branch, user: user) }
  subject { described_class.call(params) }

  describe 'call' do
    context 'successful' do
      it { expect(subject.result.status).to eq('denied') }
      it { is_expected.to be_success }
    end

    context 'not successful' do
      before do
        allow_any_instance_of(Share).to receive(:deny!).and_return(false)
        allow_any_instance_of(Share).to receive(:errors).and_return([nil])
      end

      it { is_expected.to be_failure }
    end
  end
end
