require 'rails_helper'

describe CheckIn::Create do
  subject { described_class.call(user, branch, params) }
  let(:user) { FactoryBot.build(:user) }
  let(:branch) { FactoryBot.build(:branch) }

  describe 'call' do
    context 'successful' do
      let(:params) { { date: Date.today, arrival_time_start: '12:00' } }

      it { is_expected.to be_success }

      it 'returns check in' do
        expect(subject.result).to an_instance_of(CheckIn)
      end

      it 'returns no errors' do
        expect(subject.result.errors).to be_empty
      end
    end

    context 'not successful' do
      let(:params) { { date: Date.today } }

      it { is_expected.to be_failure }

      it 'returns check in' do
        expect(subject.result).to an_instance_of(CheckIn)
      end

      it 'returns errors' do
        expect(subject.result.errors).to be_present
      end
    end
  end
end
