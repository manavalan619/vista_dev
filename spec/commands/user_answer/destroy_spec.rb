require 'rails_helper'

describe UserAnswer::Destroy do
  subject { described_class.call(answer) }

  describe 'call' do
    context 'successful' do
      let(:answer) { double(destroy: true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:answer) { double(destroy: false) }

      it { is_expected.to be_failure }
    end
  end
end
