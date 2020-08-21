require 'rails_helper'

describe Share::Authorise do
  let(:branch) { create(:branch) }
  let(:user) { create(:user) }
  let(:via) { nil }
  let(:params) { { branch: branch, user: user, via: via } }
  subject { described_class.call(params) }

  describe 'call' do
    context 'successful' do
      it { is_expected.to be_success }

      context 'when previous share does not exist' do
        it { expect { subject }.to change { Share.count }.by(1) }
        it { expect(subject.result.status).to eq('authorised') }
      end

      context 'when previous share exists' do
        let!(:share) { create(:share, :requested, branch: branch, user: user) }

        before { subject }

        it { expect(share.reload.status).to eq 'authorised' }
      end

      context 'with optional `via` attribute' do
        let(:via) { 'rspec' }

        it { expect(subject.result.via).to eq 'rspec' }
      end
    end

    context 'not successful' do
      before do
        allow_any_instance_of(Share).to receive(:authorise!).and_return(false)
        allow_any_instance_of(Share).to receive(:errors).and_return([nil])
      end

      it { is_expected.to be_failure }
    end
  end
end
