require 'rails_helper'

describe Category::Create do
  subject { described_class.call(category) }

  describe 'call' do
    context 'successful' do
      let(:category) { double(save: true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:category) { double(save: false) }

      it { is_expected.to be_failure }
    end
  end
end
