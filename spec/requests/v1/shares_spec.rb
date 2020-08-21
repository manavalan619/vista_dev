require 'rails_helper'

RSpec.describe Api::V1::Branches::ShareController, type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:branch) { FactoryBot.create(:branch) }
  let(:share) { FactoryBot.build(:share, :authorised, branch: branch, user: user) }
  subject { response }

  describe 'POST /v1/partners/:id/share' do
    before { post share_api_v1_branch_url(branch, subdomain: 'api'), headers: auth_headers(user) }

    it { is_expected.to have_http_status(204) }
  end

  describe 'DELETE /v1/partners/:id/revoke' do
    before do
      share.save
      delete revoke_api_v1_branch_url(branch, subdomain: 'api'), headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(204) }
  end

  describe 'DELETE /v1/partners/revoke' do
    before do
      share.save
      delete revoke_api_v1_branches_url(subdomain: 'api'), headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(204) }
  end
end
