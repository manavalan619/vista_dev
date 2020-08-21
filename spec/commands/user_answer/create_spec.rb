require 'rails_helper'

describe UserAnswer::Create do
  subject { described_class.call(answer) }

  describe 'call' do
    context 'successful' do
      let(:answer) { double(save: true, values: nil) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:answer) { double(save: false, values: nil, errors: [nil]) }

      it { is_expected.to be_failure }
    end
  end
end
