require 'rails_helper'

RSpec.describe 'Api::V1::MembersController', type: :request do
  subject { response }

  describe 'GET /api/v1/members' do
    before { get api_v1_status_url(subdomain: 'api') }

    it { is_expected.to have_http_status(200) }
  end
end
