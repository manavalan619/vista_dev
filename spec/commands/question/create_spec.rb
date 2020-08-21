require 'rails_helper'

describe Question::Create do
  subject { described_class.call(question) }

  describe 'call' do
    context 'successful' do
      let(:question) { double(save: true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:question) { double(save: false, errors: [nil]) }

      it { is_expected.to be_failure }
    end
  end
end
