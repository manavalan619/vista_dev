# == Schema Information
#
# Table name: questions
#
#  id                 :bigint(8)        not null, primary key
#  category_id        :integer
#  title              :citext
#  kind               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  locking_conditions :jsonb            not null
#  intro              :boolean          default(FALSE)
#  allows_note        :boolean          default(TRUE)
#  note_title         :string
#  processed_at       :datetime
#  text_style         :string           default("dark")
#  blur_background    :boolean          default(FALSE)
#  background_overlay :boolean          default(FALSE)
#
# Indexes
#
#  index_questions_on_allows_note   (allows_note)
#  index_questions_on_category_id   (category_id)
#  index_questions_on_intro         (intro)
#  index_questions_on_kind          (kind)
#  index_questions_on_processed_at  (processed_at)
#

require 'rails_helper'

RSpec.describe QuestionSerializer do
  let(:serializer) { QuestionSerializer.new(question) }
  let(:question) { FactoryBot.create(:question, :text) }
  let(:answers) { ActiveModel::Serializer::CollectionSerializer.new(question.answers) }
  let(:photo) { PhotoSerializer.new(question.photo) }
  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['id']).to eq(question.id) }
  it { expect(subject['title']).to eq(question.title) }
  it { expect(subject['category_id']).to eq(question.category_id) }
  it { expect(subject['kind']).to eq(question.kind) }
  it { expect(subject['locking_conditions']).to eq(question.locking_conditions) }
  it { expect(subject['intro']).to eq(question.intro) }
  it { expect(subject['allows_note']).to eq(question.allows_note) }
  it { expect(subject['note_title']).to eq(question.note_title) }
  # TODO: fix this
  # it { expect(subject['photo']).to eq(JSON.parse(photo.to_json)) }
  it { expect(subject['answers']).to be_an_instance_of(Array) }
  it { expect(subject['answers']).to eq(JSON.parse(answers.to_json)) }
end
