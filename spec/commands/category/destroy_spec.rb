require 'rails_helper'

describe Category::Destroy do
  subject { described_class.call(category) }

  describe 'call' do
    context 'successful' do
      let(:category) { double(destroy: true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:category) { double(destroy: false) }

      it { is_expected.to be_failure }
    end
  end
end
