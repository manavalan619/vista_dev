require 'rails_helper'

describe AnswerPolicy, type: :policy do
  subject { described_class }
  let(:user) { FactoryBot.create(:user) }
  let(:users_answer) { FactoryBot.create(:answer, user: user) }
  let(:not_users_answer) { FactoryBot.create(:answer) }

  permissions :show?, :create? do
    it { is_expected.to permit(user, users_answer) }
    it { is_expected.to permit(user, not_users_answer) }
  end

  permissions :create?, :destroy? do
    it { is_expected.to permit(user, users_answer) }
    it { is_expected.not_to permit(user, not_users_answer) }
  end

  describe 'scope' do
    it { expect(Pundit.policy_scope(user, Answer)).to eq([user_answer]) }
  end
end
