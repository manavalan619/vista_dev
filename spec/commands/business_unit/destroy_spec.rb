require 'rails_helper'

describe BusinessUnit::Destroy do
  subject { described_class.call(business_unit) }
  let(:business_unit) { FactoryBot.create(:business_unit) }

  describe 'call' do
    context 'successful' do
      before { allow(business_unit).to receive(:destroy).and_return(true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      before { allow(business_unit).to receive(:destroy).and_return(false) }

      it { is_expected.to be_failure }
    end
  end
end
