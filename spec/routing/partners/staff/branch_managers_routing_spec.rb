require 'rails_helper'

RSpec.describe Partners::Staff::BranchManagersController, type: :routing do
  let(:host) { 'http://partners.vista.test' }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "#{host}/staff/branch-managers").to \
        route_to('partners/staff/branch_managers#index')
    end

    it 'routes to #new' do
      expect(get: "#{host}/staff/branch-managers/new").to \
        route_to('partners/staff/branch_managers#new')
    end

    it 'routes to #show' do
      expect(get: "#{host}/staff/branch-managers/1").to \
        route_to('partners/staff/branch_managers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: "#{host}/staff/branch-managers/1/edit").to \
        route_to('partners/staff/branch_managers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: "#{host}/staff/branch-managers").to \
        route_to('partners/staff/branch_managers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: "#{host}/staff/branch-managers/1").to \
        route_to('partners/staff/branch_managers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: "#{host}/staff/branch-managers/1").to \
        route_to('partners/staff/branch_managers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: "#{host}/staff/branch-managers/1").to \
        route_to('partners/staff/branch_managers#destroy', id: '1')
    end
  end
end
