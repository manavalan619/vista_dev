require 'rails_helper'

describe Question::Update do
  subject { described_class.call(question, params) }

  describe 'call' do
    context 'successful' do
      let(:question) { double }
      let(:params) { double }
      before { allow(question).to receive(:update).with(params).and_return(true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:question) { double }
      let(:params) { double }
      before { allow(question).to receive(:update).with(params).and_return(false) }
      before { allow(question).to receive(:errors).and_return([nil]) }

      it { is_expected.to be_failure }
    end
  end
end
