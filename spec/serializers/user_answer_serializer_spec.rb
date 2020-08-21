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

RSpec.describe UserAnswerSerializer do
  let(:serializer) { UserAnswerSerializer.new(answer) }
  let(:answer) { FactoryBot.create(:user_answer) }
  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['id']).to eq(answer.id) }
  it { expect(subject['question_id']).to eq(answer.question_id) }
  it { expect(subject['values']).to eq(answer.values) }
  it { expect(subject['note']).to eq(answer.note) }
end
