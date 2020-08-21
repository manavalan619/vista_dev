require 'rails_helper'

describe Category::Update do
  subject { described_class.call(category, params) }

  describe 'call' do
    context 'successful' do
      let(:category) { double }
      let(:params) { double }
      before { allow(category).to receive(:update).with(params).and_return(true) }

      it { is_expected.to be_success }
    end

    context 'not successful' do
      let(:category) { double }
      let(:params) { double }
      before { allow(category).to receive(:update).with(params).and_return(false) }

      it { is_expected.to be_failure }
    end
  end
end
