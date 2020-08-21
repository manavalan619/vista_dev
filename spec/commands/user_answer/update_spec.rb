require 'rails_helper'

describe UserAnswer::Update do
  subject { described_class.call(answer, params) }

  describe 'call' do
    context 'successful' do
      let(:answer) { double }
      let(:params) { {} }
      before { allow(answer).to receive(:update).with(params).and_return(true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:answer) { double }
      let(:params) { {} }
      before { allow(answer).to receive(:update).with(params).and_return(false) }
      before { allow(answer).to receive(:errors).and_return([nil]) }

      it { is_expected.to be_failure }
    end
  end
end
