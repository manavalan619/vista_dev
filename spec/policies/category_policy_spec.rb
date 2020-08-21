require 'rails_helper'

describe CategoryPolicy, type: :policy do
  subject { described_class }
  let(:category) { FactoryBot.create(:category) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }

  permissions :show? do
    it { is_expected.to permit(admin, category) }
    it { is_expected.to permit(user, category) }
  end

  permissions :questions?, :unlocked_questions? do
    it { is_expected.not_to permit(admin, category) }
    it { is_expected.to permit(user, category) }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.to permit(admin, category) }
    it { is_expected.not_to permit(user, category) }
  end

  describe 'scope' do
    it { expect(Pundit.policy_scope(admin, Category)).to eq([category]) }
    it { expect(Pundit.policy_scope(user, Category)).to eq([category]) }
  end
end
