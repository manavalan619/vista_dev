require 'rails_helper'

describe BusinessUnitPolicy, type: :policy do
  subject { described_class }
  let(:admin) { FactoryBot.create(:admin) }
  let(:organisation) { admin.organisation }
  let(:staff_member) { FactoryBot.create(:staff_member, organisation: organisation) }
  let(:branch_manager) { FactoryBot.create(:branch_manager, organisation: organisation) }
  let(:business_unit) { FactoryBot.create(:business_unit, organisation: organisation) }
  let(:other_branch_manager) { FactoryBot.create(:branch_manager) }
  let(:other_admin) { FactoryBot.create(:admin) }

  permissions :index? do
    it { is_expected.to permit(admin, business_unit) }
    it { is_expected.to permit(branch_manager, business_unit) }
    it { is_expected.to_not permit(staff_member, business_unit) }
  end

  permissions :show? do
    it { is_expected.to permit(admin, business_unit) }
    it { is_expected.to permit(branch_manager, business_unit) }
    it { is_expected.to_not permit(staff_member, business_unit) }
    it { is_expected.to_not permit(other_branch_manager, business_unit) }
    it { is_expected.to_not permit(other_admin, business_unit) }
  end

  permissions :update?, :create?, :destroy? do
    it { is_expected.to permit(admin, business_unit) }
    it { is_expected.to_not permit(branch_manager, business_unit) }
    it { is_expected.to_not permit(staff_member, business_unit) }
    it { is_expected.to_not permit(other_branch_manager, business_unit) }
    it { is_expected.to_not permit(other_admin, business_unit) }
  end

  describe 'scope' do
    it do
      expect(Pundit.policy_scope(staff_member, BusinessUnit)).to \
        eq(organisation.business_units)
    end
  end
end
