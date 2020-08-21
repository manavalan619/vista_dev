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

RSpec.describe Interaction, type: :model do
  subject { build(:interaction) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:staff_member) }
    it { is_expected.to belong_to(:branch) }
    it { is_expected.to belong_to(:category) }
  end

  context 'mood' do
    subject { build(:interaction, :mood) }
    let(:moods) { Interaction::MOODS }

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:type) }
      it { is_expected.to validate_presence_of(:description) }
      it { is_expected.to validate_inclusion_of(:description).in_array(moods) }
    end
  end

  context 'recommendation' do
    subject { build(:interaction, :recommendation) }

    describe 'validations' do
      it { is_expected.to be_valid }
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:staff_member) }
      it { is_expected.to validate_presence_of(:branch) }
      it { is_expected.to validate_presence_of(:description) }
    end
  end
end
