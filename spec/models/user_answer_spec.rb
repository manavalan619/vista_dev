# == Schema Information
#
# Table name: user_answers
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  note        :text
#  values      :text
#
# Indexes
#
#  index_user_answers_on_question_id  (question_id)
#  index_user_answers_on_user_id      (user_id)
#

require 'rails_helper'

RSpec.describe UserAnswer, type: :model do
  subject { answer }

  describe 'versioning' do
    let(:answer) { build(:user_answer) }

    it { is_expected.to be_versioned }
  end

  describe 'associations' do
    let(:answer) { build(:user_answer) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:question) }
  end

  describe 'validations' do
    let(:answer) { build(:user_answer) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:question) }

    context 'kind' do
      let(:question) { create(:question, :text) }

      context 'with no question' do
        let(:answer) { build(:user_answer, question: nil) }

        it { is_expected.to be_invalid }
        it { expect(subject.errors_on(:values)).to include('are invalid') }
      end

      context 'text question' do
        before { allow(subject).to receive(:text?).and_return(true) }

        it { is_expected.to_not validate_presence_of(:values) }

        context 'with invalid keys' do
          let(:answer) { build(:user_answer, question: question, values: ['foobar']) }

          it { is_expected.not_to be_valid }
          it { expect(subject.errors_on(:values)).to include('are invalid') }
        end

        context 'with valid key' do
          let(:answer) { build(:user_answer, question: question, values: 'some test') }

          it { is_expected.to be_valid }
        end

        context 'with no values' do
          let(:answer) { build(:user_answer, values: nil) }

          it { is_expected.to be_valid }
        end
      end

      context 'number question' do
        let(:question) { create(:question, :number) }

        before { allow(subject).to receive(:text?).and_return(false) }

        it { is_expected.to validate_presence_of(:values) }

        context 'with invalid keys' do
          let(:answer) { build(:user_answer, question: question, values: ['foobar']) }

          it { is_expected.not_to be_valid }
          it { expect(subject.errors_on(:values)).to include('are invalid') }
        end

        context 'with valid key' do
          let(:answer) { build(:user_answer, question: question, values: 2.34) }

          it { is_expected.to be_valid }
        end

        context 'with no values' do
          let(:answer) { build(:user_answer, values: nil) }

          it { is_expected.to be_invalid }
          it { expect(subject.errors_on(:values)).to include("can't be blank") }
        end
      end

      context 'time question' do
        let(:question) { create(:question, :time) }

        before { allow(subject).to receive(:text?).and_return(false) }

        it { is_expected.to validate_presence_of(:values) }

        context 'with invalid keys' do
          let(:answer) { build(:user_answer, question: question, values: ['foobar']) }

          it { is_expected.not_to be_valid }
          it { expect(subject.errors_on(:values)).to include('are invalid') }
        end

        context 'with valid key' do
          let(:answer) { build(:user_answer, question: question, values: Date.new(2016, 8, 13)) }

          it { is_expected.to be_valid }
        end

        context 'with no values' do
          let(:answer) { build(:user_answer, values: nil) }

          it { is_expected.to be_invalid }
          it { expect(subject.errors_on(:values)).to include("can't be blank") }
        end
      end

      context 'option question' do
        let(:question) { create(:question, :option) }

        before { allow(subject).to receive(:text?).and_return(false) }

        it { is_expected.to validate_presence_of(:values) }

        context 'with invalid keys' do
          let(:answer) { build(:user_answer, question: question, values: ['foobar']) }

          it { is_expected.not_to be_valid }
          it { expect(subject.errors_on(:values)).to include('are invalid') }
        end

        context 'with valid key' do
          let(:answer) { build(:user_answer, question: question, values: 'foobar') }

          it { is_expected.to be_valid }
        end

        context 'with no values' do
          let(:answer) { build(:user_answer, values: nil) }

          it { is_expected.to be_invalid }
          it { expect(subject.errors_on(:values)).to include("can't be blank") }
        end
      end

      context 'ordered_list question' do
        let(:question) { create(:question, :ordered_list) }

        before { allow(subject).to receive(:text?).and_return(false) }

        it { is_expected.to validate_presence_of(:values) }

        context 'with invalid keys' do
          let(:answer) { build(:user_answer, question: question, values: 'foobar') }

          it { is_expected.not_to be_valid }
          it { expect(subject.errors_on(:values)).to include('are invalid') }
        end

        context 'with valid key' do
          let(:answer) { build(:user_answer, question: question, values: ['foobar', 'foobaz']) }

          it { is_expected.to be_valid }
        end

        context 'with no values' do
          let(:answer) { build(:user_answer, values: nil) }

          it { is_expected.to be_invalid }
          it { expect(subject.errors_on(:values)).to include("can't be blank") }
        end
      end

      context 'unordered_list question' do
        let(:question) { create(:question, :unordered_list) }

        before { allow(subject).to receive(:text?).and_return(false) }

        it { is_expected.to validate_presence_of(:values) }

        context 'with invalid keys' do
          let(:answer) { build(:user_answer, question: question, values: 'foobar') }

          it { is_expected.not_to be_valid }
          it { expect(subject.errors_on(:values)).to include('are invalid') }
        end

        context 'with valid key' do
          let(:answer) { build(:user_answer, question: question, values: ['foobar', 'foobaz']) }

          it { is_expected.to be_valid }
        end

        context 'with no values' do
          let(:answer) { build(:user_answer, values: nil) }

          it { is_expected.to be_invalid }
          it { expect(subject.errors_on(:values)).to include("can't be blank") }
        end
      end
    end
  end
end
