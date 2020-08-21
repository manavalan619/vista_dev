# == Schema Information
#
# Table name: interactions
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)        not null
#  staff_member_id :bigint(8)
#  branch_id       :bigint(8)
#  category_id     :bigint(8)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  type            :string           default(""), not null
#
# Indexes
#
#  index_interactions_on_branch_id        (branch_id)
#  index_interactions_on_category_id      (category_id)
#  index_interactions_on_staff_member_id  (staff_member_id)
#  index_interactions_on_type             (type)
#  index_interactions_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (staff_member_id => staff_members.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe InteractionSerializer do
  subject { JSON.parse(InteractionSerializer.new(interaction).to_json) }

  context 'Mood' do
    let(:interaction) { FactoryBot.create(:interaction, :mood) }

    it { expect(subject['id']).to eq(interaction.id) }
    it { expect(subject['value']).to eq(interaction.value) }
    it { expect(subject['date']).to eq(interaction.created_at.iso8601(3)) }
    it { expect(subject['type']).to eq('mood') }
  end

  # context 'Recommendation' do
  #   let(:interaction) { FactoryBot.create(:interaction) }

  #   it { expect(subject['id']).to eq(interaction.id) }
  #   it { expect(subject['value']).to eq(interaction.value) }
  #   it { expect(subject['date']).to eq(interaction.created_at.iso8601(3)) }
  #   # it { expect(subject['type']).to eq('Recommendation') }
  # end
end
