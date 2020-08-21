require 'rails_helper'

RSpec.describe 'Api::V1::DevicesController', type: :request do
  let!(:user) { create(:user) }
  let(:device_params) { { token: SecureRandom.uuid, platform: 'ios' } }
  subject { response }

  describe 'POST /api/v1/devices' do
    before do
      post api_v1_devices_url(subdomain: 'api'), params: device_params, headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(204) }
  end
end
