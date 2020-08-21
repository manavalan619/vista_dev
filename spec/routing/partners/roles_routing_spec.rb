require 'rails_helper'

RSpec.describe Partners::RolesController, type: :routing do
  let(:host) { 'http://partners.vista.test' }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "#{host}/roles").to \
        route_to('partners/roles#index')
    end

    it 'routes to #new' do
      expect(get: "#{host}/roles/new").to \
        route_to('partners/roles#new')
    end

    it 'routes to #show' do
      expect(get: "#{host}/roles/1").to \
        route_to('partners/roles#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{host}/roles/1/edit").to \
        route_to('partners/roles#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: "#{host}/roles").to \
        route_to('partners/roles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{host}/roles/1").to \
        route_to('partners/roles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{host}/roles/1").to \
        route_to('partners/roles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{host}/roles/1").to \
        route_to('partners/roles#destroy', id: '1')
    end
  end
end
