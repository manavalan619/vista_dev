require 'rails_helper'

RSpec.describe Api::V1::MeController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'routes to #show via GET' do
      expect(get: "#{host}/v1/me").to \
        route_to('api/v1/me#show', format: :json)
    end

    it 'routes to #update via PUT' do
      expect(put: "#{host}/v1/me").to \
        route_to('api/v1/me#update', format: :json)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{host}/v1/me").to \
        route_to('api/v1/me#update', format: :json)
    end

    it 'does not route to #create via POST' do
      expect(post: "#{host}/v1/me").to_not be_routable
    end

    it 'does not route to #destroy via DELETE' do
      expect(delete: "#{host}/v1/me").to_not be_routable
    end
  end
end
