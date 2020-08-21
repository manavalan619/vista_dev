require 'rails_helper'

RSpec.describe Partners::RolesController, type: :controller do
  let(:organisation) { build(:organisation) }
  let(:business_unit) { build(:business_unit, organisation: organisation) }
  let!(:role) { create(:role, business_unit: business_unit) }
  let(:valid_attributes) { attributes_for(:role, business_unit_id: business_unit.id) }
  let(:invalid_attributes) { attributes_for(:role, name: nil, business_unit_id: business_unit.id) }
  let(:valid_session) { {} }

  login_admin

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {
        business_unit_id: business_unit.to_param
      }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: {
        business_unit_id: business_unit.to_param, id: role.to_param
      }, session: valid_session
      expect(response).to redirect_to([:edit, :partners, business_unit, role])
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { business_unit_id: business_unit.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { business_unit_id: business_unit, id: role.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Role' do
        expect {
          post :create, params: {
            business_unit_id: business_unit, role: valid_attributes
          }, session: valid_session
        }.to change(Role, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: {
          business_unit_id: business_unit, role: valid_attributes
        }, session: valid_session
        expect(response).to redirect_to([:partners, business_unit, :roles])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {
          business_unit_id: business_unit, role: { name: nil }
        }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New role' } }

      it 'updates the requested role' do
        put :update, params: {
          business_unit_id: business_unit, id: role.to_param, role: new_attributes
        }, session: valid_session
        role.reload
        expect(role.name).to eq new_attributes[:name]
      end

      it 'redirects to the index' do
        put :update, params: {
          business_unit_id: business_unit, id: role.to_param, role: valid_attributes
        }, session: valid_session
        expect(response).to redirect_to([:partners, business_unit, :roles])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {
          business_unit_id: business_unit, id: role.to_param, role: invalid_attributes
        }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with replacement role' do
      let!(:replacement_role) { create(:role, business_unit: business_unit) }

      it 'destroys the requested role' do
        expect {
          delete :destroy, params: {
            business_unit_id: business_unit,
            id: role.to_param,
            replace_with: replacement_role.to_param
          }, session: valid_session
        }.to change(Role, :count).by(-1)
      end

      it 'redirects to the roles list' do
        delete :destroy, params: {
          business_unit_id: business_unit.to_param,
          id: role.to_param,
          replace_with: replacement_role.to_param
        }, session: valid_session
        expect(response).to redirect_to([:partners, business_unit, :roles])
      end
    end

    context 'without replacement role' do
      it 'does not destroy the requested role' do
        expect {
          delete :destroy, params: { business_unit_id: business_unit.to_param, id: role.to_param }, session: valid_session
        }.to_not change(Role, :count)
      end

      it 'redirects to the role edit page' do
        delete :destroy, params: { business_unit_id: business_unit.to_param, id: role.to_param }, session: valid_session
        expect(response).to redirect_to([:edit, :partners, business_unit, role])
      end
    end
  end
end
