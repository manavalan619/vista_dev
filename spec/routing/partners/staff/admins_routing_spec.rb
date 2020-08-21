require 'rails_helper'

RSpec.describe Partners::Staff::AdminsController, type: :routing do
  let(:host) { 'http://partners.vista.test' }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "#{host}/staff/admins").to \
        route_to('partners/staff/admins#index')
    end

    it 'routes to #new' do
      expect(get: "#{host}/staff/admins/new").to \
        route_to('partners/staff/admins#new')
    end

    it 'routes to #show' do
      expect(get: "#{host}/staff/admins/1").to \
        route_to('partners/staff/admins#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{host}/staff/admins/1/edit").to \
        route_to('partners/staff/admins#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: "#{host}/staff/admins").to \
        route_to('partners/staff/admins#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{host}/staff/admins/1").to \
        route_to('partners/staff/admins#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{host}/staff/admins/1").to \
        route_to('partners/staff/admins#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{host}/staff/admins/1").to \
        route_to('partners/staff/admins#destroy', id: '1')
    end
  end
end
