require 'rails_helper'

RSpec.describe "Admin::Roles", type: :request do
  before { skip('TODO: required?') }

  before { host! 'admin.vista.test' }

  describe "GET /admin_roles" do
    it "works! (now write some real specs)" do
      get admin_roles_path
      expect(response).to have_http_status(200)
    end
  end
end
