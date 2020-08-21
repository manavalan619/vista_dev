require 'rails_helper'

describe BusinessUnit::Update do
  subject { described_class.call(business_unit, params) }
  let(:business_unit) { FactoryBot.create(:business_unit) }

  describe 'call' do
    context 'successful' do
      let(:params) { { name: 'Test' } }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:params) { { name: nil } }

      it { is_expected.to be_failure }
    end
  end
end
