require 'rails_helper'

RSpec.describe 'Api::V1::MeController', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:user_params) { { first_name: 'test', last_name: 'test', email: 'test@example.com', password: 'monkey123' } }

  subject { response }

  describe 'GET /api/v1/me' do
    before { get api_v1_me_url(subdomain: 'api'), headers: auth_headers(user) }

    it { is_expected.to have_http_status(200) }
  end

  describe 'PUT /api/v1/me' do
    context 'successful' do
      before do
        allow_any_instance_of(SimpleCommand).to \
          receive(:success?).and_return(true)
        put api_v1_me_url(subdomain: 'api'),
            params: { user: user_params }, headers: auth_headers(user)
      end

      it { is_expected.to have_http_status(200) }
    end

    context 'not successful' do
      before do
        allow_any_instance_of(SimpleCommand).to \
          receive(:success?).and_return(false)
        put api_v1_me_url(subdomain: 'api'),
            params: { user: user_params }, headers: auth_headers(user)
      end

      it { is_expected.to have_http_status(422) }
    end
  end

  describe 'PATCH /api/v1/me' do
    context 'successful' do
      before do
        allow_any_instance_of(SimpleCommand).to \
          receive(:success?).and_return(true)
        patch api_v1_me_url(subdomain: 'api'),
              params: { user: user_params }, headers: auth_headers(user)
      end

      it { is_expected.to have_http_status(200) }
    end

    context 'not successful' do
      before do
        allow_any_instance_of(SimpleCommand).to \
          receive(:success?).and_return(false)
        patch api_v1_me_url(subdomain: 'api'),
              params: { user: user_params }, headers: auth_headers(user)
      end

      it { is_expected.to have_http_status(422) }
    end
  end
end
