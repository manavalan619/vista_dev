require 'rails_helper'

describe Branch::Update do
  subject { described_class.call(branch, params) }
  let(:branch) { FactoryBot.create(:branch) }

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
