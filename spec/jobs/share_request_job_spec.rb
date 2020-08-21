require 'rails_helper'

RSpec.describe ShareRequestJob, type: :job do
  let(:branch) { create(:branch) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:member_ids) { [user1, user2, user3].map(&:member_id) }

  context 'when no users have shared' do
    it 'calls `Share::Request` for each member_id' do
      expect(Share::Request).to \
        receive(:call).once.ordered.with(
          branch: branch, user: user1.id, via: 'proximity'
        )
      expect(Share::Request).to \
        receive(:call).once.ordered.with(
          branch: branch, user: user2.id, via: 'proximity'
        )
      expect(Share::Request).to \
        receive(:call).once.ordered.with(
          branch: branch, user: user3.id, via: 'proximity'
        )
      ShareRequestJob.perform_now(branch, member_ids)
    end
  end

  context 'when some users have shared' do
    before { create(:share, :authorised, user: user1, branch: branch) }

    it 'calls `Share::Request` for each non-authorised member_id' do
      expect(Share::Request).to \
        receive(:call).once.ordered.with(
          branch: branch, user: user2.id, via: 'proximity'
        )
      expect(Share::Request).to \
        receive(:call).once.ordered.with(
          branch: branch, user: user3.id, via: 'proximity'
        )
      ShareRequestJob.perform_now(branch, member_ids)
    end
  end

  context 'when all users have shared' do
    before do
      create(:share, :authorised, user: user1, branch: branch)
      create(:share, :authorised, user: user2, branch: branch)
      create(:share, :authorised, user: user3, branch: branch)
    end

    it 'does not call `Share::Request`' do
      expect(Share::Request).to_not receive(:call)
      ShareRequestJob.perform_now(branch, member_ids)
    end
  end
end
