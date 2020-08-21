require 'rails_helper'

RSpec.describe Admin::RolesController, type: :controller do
  let(:valid_attributes) {
    skip('Add a hash of attributes valid for your model')
  }

  let(:invalid_attributes) {
    skip('Add a hash of attributes invalid for your model')
  }

  let(:valid_session) { {} }

  # TODO: check whether this contoller is actually needed
  before { skip('check whether this contoller is actually needed') }

  describe 'GET #index' do
    it 'returns a success response' do
      role = Role.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      role = Role.create! valid_attributes
      get :show, params: { id: role.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      role = Role.create! valid_attributes
      get :edit, params: { id: role.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Role' do
        expect {
          post :create, params: { admin_role: valid_attributes }, session: valid_session
        }.to change(Role, :count).by(1)
      end

      it 'redirects to the created admin_role' do
        post :create, params: { admin_role: valid_attributes }, session: valid_session
        expect(response).to redirect_to(Role.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { admin_role: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        skip('Add a hash of attributes valid for your model')
      }

      it 'updates the requested admin_role' do
        role = Role.create! valid_attributes
        put :update, params: { id: role.to_param, admin_role: new_attributes }, session: valid_session
        role.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the admin_role' do
        role = Role.create! valid_attributes
        put :update, params: { id: role.to_param, admin_role: valid_attributes }, session: valid_session
        expect(response).to redirect_to(role)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        role = Role.create! valid_attributes
        put :update, params: { id: role.to_param, admin_role: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested admin_role' do
      role = Role.create! valid_attributes
      expect {
        delete :destroy, params: { id: role.to_param }, session: valid_session
      }.to change(Role, :count).by(-1)
    end

    it 'redirects to the roles list' do
      role = Role.create! valid_attributes
      delete :destroy, params: { id: role.to_param }, session: valid_session
      expect(response).to redirect_to(roles_url)
    end
  end
end
