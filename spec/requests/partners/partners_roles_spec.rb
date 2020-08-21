require 'rails_helper'

RSpec.describe "Partners::Roles", type: :request do
  before { skip('implement me') }

  before { host! 'partners.vista.test' }

  describe "GET /partners_roles" do
    it "works! (now write some real specs)" do
      get partners_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
