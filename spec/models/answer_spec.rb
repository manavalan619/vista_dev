# == Schema Information
#
# Table name: answers
#
#  id          :bigint(8)        not null, primary key
#  question_id :bigint(8)
#  title       :citext
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position    :integer          default(0)
#
# Indexes
#
#  index_answers_on_position     (position)
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { build(:answer) }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  it { is_expected.to be_versioned }

  describe 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to have_one(:photo) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:question) }
    it { is_expected.to_not validate_presence_of(:description) }
  end

  describe 'position handling' do
    let(:question) { create(:question, :option, answers_count: 2) }

    describe '#set_position' do
      subject { build(:answer, question: question) }

      it 'sets position before create' do
        expect(subject.position).to eq 3
      end
    end
  end
end
