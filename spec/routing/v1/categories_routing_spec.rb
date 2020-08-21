require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "#{host}/v1/categories").to \
        route_to('api/v1/categories#index', format: :json)
    end

    it 'routes to #show via GET' do
      expect(get: "#{host}/v1/categories/5").to \
        route_to('api/v1/categories#show', id: '5', format: :json)
    end

    it 'does not route to #update via PUT' do
      expect(put: "#{host}/v1/categories/5").to_not be_routable
    end

    it 'does not route to #update via PATCH' do
      expect(patch: "#{host}/v1/categories/5").to_not be_routable
    end
  end
end
