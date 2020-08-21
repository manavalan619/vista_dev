require 'rails_helper'

RSpec.describe Api::V1::UserAnswersController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'does not route to #show via GET' do
      expect(get: "#{host}/v1/questions/4/answer").to_not be_routable
    end

    it 'routes to #create via POST' do
      expect(post: "#{host}/v1/questions/5/answer").to \
        route_to('api/v1/questions/answer#create', id: '5', format: :json)
    end

    it 'does not route to #update via PUT' do
      expect(put: "#{host}/v1/questions/6/answer").to_not be_routable
    end

    it 'does not route to #update via PATCH' do
      expect(patch: "#{host}/v1/questions/7/answer").to_not be_routable
    end

    it 'routes to #destroy via DELETE' do
      expect(delete: "#{host}/v1/questions/8/answer").to \
        route_to('api/v1/questions/answer#destroy', id: '8', format: :json)
    end
  end
end
