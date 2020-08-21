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

RSpec.describe CategoryUpdateSerializer do
  let(:serializer) { CategoryUpdateSerializer.new(category_update) }
  let(:questions) { create_list(:question, 3, :text) }
  let(:category_update) { create(:category_update, question_ids: questions.pluck(:id)) }
  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['id']).to eq(category_update.id) }
  it { expect(subject['category_id']).to eq(category_update.category_id) }
  it { expect(subject['question_ids']).to eq(category_update.question_ids) }
  it { expect(subject['created_at']).to eq(category_update.created_at.iso8601(3)) }
end
