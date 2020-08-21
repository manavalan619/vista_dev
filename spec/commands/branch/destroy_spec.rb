require 'rails_helper'

describe Branch::Destroy do
  subject { described_class.call(branch) }
  let(:branch) { FactoryBot.create(:branch) }

  describe 'call' do
    context 'successful' do
      before { allow(branch).to receive(:destroy).and_return(true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      before { allow(branch).to receive(:destroy).and_return(false) }

      it { is_expected.to be_failure }
    end
  end
end
