require 'rails_helper'

describe Branch::Create do
  subject { described_class.call(branch) }

  describe 'call' do
    context 'successful' do
      let(:branch) { FactoryBot.build(:branch) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:branch) { FactoryBot.build(:branch, name: nil) }

      it { is_expected.to be_failure }
    end
  end
end
