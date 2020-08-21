require 'rails_helper'

describe BusinessUnit::Create do
  subject { described_class.call(business_unit) }

  describe 'call' do
    context 'successful' do
      let(:business_unit) { FactoryBot.build(:business_unit) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:business_unit) { FactoryBot.build(:business_unit, name: nil) }

      it { is_expected.to be_failure }
    end
  end
end
