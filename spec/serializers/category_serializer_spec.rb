# == Schema Information
#
# Table name: categories
#
#  id                      :bigint(8)        not null, primary key
#  title                   :citext
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  ancestry                :string
#  description             :text
#  position                :integer          default(0), not null
#  initial                 :boolean          default(FALSE)
#  visibility_conditions   :jsonb            not null
#  text_style              :string           default("dark")
#  subtree_questions_count :integer          default(0)
#  questions_count         :integer          default(0)
#
# Indexes
#
#  index_categories_on_ancestry               (ancestry)
#  index_categories_on_ancestry_and_position  (ancestry,position)
#

require 'rails_helper'

RSpec.describe CategorySerializer do
  let(:serializer) { CategorySerializer.new(category) }
  let(:category) { create(:nested_category) }
  subject { JSON.parse(serializer.to_json) }

  it { expect(subject['id']).to eq(category.id) }
  it { expect(subject['title']).to eq(category.title) }
  it { expect(subject['parent_id']).to eq(category.parent.id) }
  it { expect(subject['visibility_conditions']).to eq(category.visibility_conditions_tree) }
end
