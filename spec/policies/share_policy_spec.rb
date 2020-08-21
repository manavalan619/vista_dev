require 'rails_helper'

describe SharePolicy, type: :policy do
  subject { described_class }
  let(:user) { create(:user) }
  let(:share) { create(:share, :requested, user: user) }
  let(:other_user) { create(:user) }

  permissions :authorise? do
    it { is_expected.to permit(user, share) }
    it { is_expected.to_not permit(other_user, share) }
  end

  permissions :revoke? do
    it { is_expected.to permit(user, share) }
    it { is_expected.not_to permit(other_user, share) }
  end
end
