require 'rails_helper'

RSpec.describe "Partners::Staff::Admins", type: :request do
  before { skip('implement me') }

  before { host! 'partners.vista.test' }

  describe "GET /partners_staff_admins" do
    it "works! (now write some real specs)" do
      get partners_staff_admins_path
      expect(response).to have_http_status(200)
    end
  end
end
