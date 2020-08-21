require 'rails_helper'

describe QuestionPolicy, type: :policy do
  subject { described_class }
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:question) { FactoryBot.create(:question, :text) }

  permissions :show? do
    it { is_expected.to permit(user, question) }
    it { is_expected.to permit(admin, question) }
  end

  permissions :unlocked? do
    it { is_expected.to permit(user, question) }
    it { is_expected.not_to permit(admin, question) }
  end

  permissions :create?, :update?, :destroy? do
    it { is_expected.not_to permit(user, question) }
    it { is_expected.to permit(admin, question) }
  end

  describe 'scope' do
    it { expect(Pundit.policy_scope(user, Question)).to eq([question]) }
    it { expect(Pundit.policy_scope(admin, Question)).to eq([question]) }
  end
end
