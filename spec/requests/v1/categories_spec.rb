require 'rails_helper'

RSpec.describe 'Api::V1::CategoriesController', type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let(:category_params) { { category: { title: 'Hotels' } } }
  subject { response }

  describe 'GET /api/v1/categories' do
    before do
      get api_v1_categories_url(subdomain: 'api'),
          headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(200) }
    it { expect(assigns(:categories)).to eq([category]) }
  end

  describe 'GET /api/v1/categories/:id' do
    before do
      get api_v1_category_url(category.id, subdomain: 'api'),
          headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(200) }
    it { expect(assigns(:category)).to eq(category) }
  end

  describe 'POST /api/v1/categories' do
    it 'raises routing error' do
      expect do
        post api_v1_categories_url(subdomain: 'api'),
             params: category_params,
             headers: auth_headers(user)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'PUT /api/v1/categories/:id' do
    it 'raises routing error' do
      expect do
        put api_v1_category_url(category.id, subdomain: 'api'),
            params: category_params, headers: auth_headers(user)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'PATCH /api/v1/categories/:id' do
    it 'raises routing error' do
      expect do
        patch api_v1_category_url(category.id, subdomain: 'api'),
              params: category_params,
              headers: auth_headers(user)
      end.to raise_error(ActionController::RoutingError)
    end
  end

  describe 'DELETE /api/v1/categories/:id' do
    it 'raises routing error' do
      expect do
        delete api_v1_category_url(category.id, subdomain: 'api'),
               headers: auth_headers(user)
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
