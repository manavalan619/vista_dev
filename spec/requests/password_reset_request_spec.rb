require 'rails_helper'

RSpec.describe 'Api::V1::PasswordResetsController', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe '#create' do
    context 'with an existing email' do
      before do
        allow(User).to receive(:find_by).and_return(user)
      end

      it 'should find the correct user' do
        expect(User).to receive(:find_by).with(email: user.email)
        post api_v1_password_reset_url(subdomain: 'api'), params: { email: user.email }
      end

      it 'should setup a reset token for the given email' do
        expect(user).to receive(:send_reset_password_instructions)
        post api_v1_password_reset_url(subdomain: 'api'), params: { email: user.email }
      end

      it 'should return success' do
        post api_v1_password_reset_url(subdomain: 'api'), params: { email: user.email }
        expect(response).to be_success
        expect(response.status).to eq 202
      end
    end

    context 'with an invalid email' do
      before do
        allow(User).to receive(:find_by).and_return(nil)
      end

      it 'should return an error' do
        post api_v1_password_reset_url(subdomain: 'api'), params: { email: user.email }
        expect(response.status).to eq 400
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      let(:params) { { token: 'valid.token.here', password: 'password', password_confirmation: 'password' } }

      before do
        allow(User).to receive(:reset_password_by_token).and_return(user)
      end

      it 'should be a success' do
        put api_v1_password_reset_url(subdomain: 'api'), params: params
        expect(response.status).to eq 202
      end
    end

    context 'with invalid params' do
      let(:params) { { password: 'password1', password_confirmation: 'password' } }
      before do
        user.send_reset_password_instructions
      end

      it 'should return an error' do
        put api_v1_password_reset_url(subdomain: 'api'),
            params: params.merge(token: user.reset_password_token)
        expect(response.status).to eq 400
      end
    end
  end
end
