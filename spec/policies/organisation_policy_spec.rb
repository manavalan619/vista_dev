require 'rails_helper'

describe OrganisationPolicy, type: :policy do
  subject { described_class }
  let(:admin) { FactoryBot.create(:admin) }
  let(:organisation) { admin.organisation }
  let(:staff_member) { FactoryBot.create(:staff_member) }
  let(:user) { FactoryBot.create(:user) }

  permissions :show?, :update? do
    it { is_expected.to permit(admin, organisation) }
    it { is_expected.not_to permit(staff_member, organisation) }
  end

  permissions :create?, :destroy? do
    it { is_expected.to_not permit(admin, organisation) }
    it { is_expected.to_not permit(staff_member, organisation) }
  end

  describe 'scope' do
    it { expect(Pundit.policy_scope(admin, Organisation)).to eq([organisation]) }
  end
end
