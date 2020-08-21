require 'rails_helper'

RSpec.describe Api::V1::Categories::IgnoreController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'routes to #ignore via POST' do
      expect(post: "#{host}/v1/categories/5/ignore").to \
        route_to('api/v1/categories/ignore#create', id: '5', format: :json)
    end

    it 'routes to #ignore via DELETE' do
      expect(delete: "#{host}/v1/categories/5/ignore").to \
        route_to('api/v1/categories/ignore#destroy', id: '5', format: :json)
    end
  end
end
