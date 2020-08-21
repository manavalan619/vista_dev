require 'rails_helper'

RSpec.describe "Partners::Staff::BranchManagers", type: :request do
  before { skip('implement me') }

  before { host! 'partners.vista.test' }

  describe "GET /partners_staff_branch_managers" do
    it "works! (now write some real specs)" do
      get partners_staff_branch_managers_path
      expect(response).to have_http_status(200)
    end
  end
end
