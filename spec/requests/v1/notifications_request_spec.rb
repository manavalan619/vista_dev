require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :request do
  let!(:user) { create(:user) }
  let(:branch) { create(:branch) }
  let(:notification) { create(:share_request_notification, user: user) }
  subject { response }

  describe 'GET /v1/notifications' do
    before do
      get api_v1_notifications_url(subdomain: 'api'), headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(200) }
  end

  describe 'PUT /v1/notifications/:id' do
    before do
      put api_v1_notification_url(notification, subdomain: 'api'),
          params: { notification: { response: 'authorised' } },
          headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(204) }
  end
end
