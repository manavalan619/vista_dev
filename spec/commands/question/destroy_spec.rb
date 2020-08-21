require 'rails_helper'

describe Question::Destroy do
  subject { described_class.call(question) }

  describe 'call' do
    context 'successful' do
      let(:question) { double(destroy: true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:question) { double(destroy: false) }

      it { is_expected.to be_failure }
    end
  end
end
