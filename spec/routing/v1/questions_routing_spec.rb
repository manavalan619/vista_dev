require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :routing do
  let(:host) { 'http://api.vista.test' }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "#{host}/v1/questions").to \
        route_to('api/v1/questions#index', format: :json)
    end

    it 'routes to #show via GET' do
      expect(get: "#{host}/v1/questions/7").to \
        route_to('api/v1/questions#show', id: '7', format: :json)
    end
  end
end
