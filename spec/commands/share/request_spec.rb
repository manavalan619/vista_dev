require 'rails_helper'

describe Share::Request do
  let(:branch) { create(:branch) }
  let(:user) { create(:user) }
  let(:via) { nil }
  let(:params) { { branch: branch, user: user, via: via } }
  subject { described_class.call(params) }

  describe 'call' do
    context 'successful' do
      it { expect { subject }.to change { Share.count }.by(1) }
      it { is_expected.to be_success }

      context 'with optional `via` attribute' do
        let(:via) { 'rspec' }

        it { expect(subject.result.via).to eq 'rspec' }
      end
    end

    context 'not successful' do
      before do
        allow_any_instance_of(Share).to receive(:request!).and_return(false)
        allow_any_instance_of(Share).to receive(:errors).and_return([nil])
      end

      it { is_expected.to be_failure }
    end
  end
end
