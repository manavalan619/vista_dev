require 'rails_helper'

RSpec.describe Api::V1::Branches::ShareController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'routes to #share via POST' do
      expect(post: "#{host}/v1/partners/5/share").to \
        route_to('api/v1/branches/share#create', id: '5', format: :json)
    end

    it 'routes to #revoke via DELETE' do
      expect(delete: "#{host}/v1/partners/5/revoke").to \
        route_to('api/v1/branches/share#destroy', id: '5', format: :json)
    end

    it 'routes to #revoke_all via DELETE' do
      expect(delete: "#{host}/v1/partners/revoke").to \
        route_to('api/v1/branches/share#revoke_all', format: :json)
    end
  end
end
