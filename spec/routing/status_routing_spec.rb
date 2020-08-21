require 'rails_helper'

RSpec.describe Api::V1::StatusController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'routes to #ping' do
      expect(get: "#{host}/v1/status").to \
        route_to('api/v1/status#ping', format: :json)
    end
  end
end
