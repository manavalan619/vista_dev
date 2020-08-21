require 'rails_helper'

RSpec.describe Admin::QuestionsController, type: :routing do
  let(:host) { 'http://admin.vista.test' }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "#{host}/questions").to route_to('admin/questions#index')
    end

    it 'routes to #new' do
      expect(get: "#{host}/questions/new").to route_to('admin/questions#new')
    end

    it 'routes to #show' do
      expect(get: "#{host}/questions/1").to \
        route_to('admin/questions#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{host}/questions/1/edit").to \
        route_to('admin/questions#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: "#{host}/questions").to route_to('admin/questions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{host}/questions/1").to \
        route_to('admin/questions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{host}/questions/1").to \
        route_to('admin/questions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{host}/questions/1").to \
        route_to('admin/questions#destroy', id: '1')
    end
  end
end
