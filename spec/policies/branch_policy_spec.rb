require 'rails_helper'

describe BranchPolicy, type: :policy do
  subject { described_class }
  let(:admin) { FactoryBot.create(:admin) }
  let(:organisation) { admin.organisation }
  let(:business_unit) { FactoryBot.create(:business_unit, organisation: organisation) }
  let(:branch_manager) { FactoryBot.create(:branch_manager, organisation: organisation) }
  let(:other_admin) { FactoryBot.create(:admin) }
  let(:branch) { FactoryBot.create(:branch, business_unit: business_unit) }

  permissions :show?, :update?, :create?, :destroy? do
    it { is_expected.to permit(admin, branch) }
    it { is_expected.not_to permit(other_admin, branch) }
    it { is_expected.not_to permit(branch_manager, branch) }
  end

  describe 'scope' do
    it { expect(Pundit.policy_scope(admin, Branch)).to eq(organisation.branches) }
  end
end
