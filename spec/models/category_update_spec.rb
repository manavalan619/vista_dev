# == Schema Information
#
# Table name: category_updates
#
#  id           :bigint(8)        not null, primary key
#  category_id  :bigint(8)
#  question_ids :integer          default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_category_updates_on_category_id   (category_id)
#  index_category_updates_on_question_ids  (question_ids) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

require 'rails_helper'

RSpec.describe CategoryUpdate, type: :model do
  subject { build(:category_update) }

  describe 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:question_ids) }
  end

  describe '#questions' do
    it 'returns ActiveRecord::Association of Questions' do
      questions = create_list(:question, 3, :text)
      subject.question_ids = questions.pluck(:id)
      expect(subject.questions).to eq(questions)
    end
  end
end
