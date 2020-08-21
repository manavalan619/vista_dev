require 'rails_helper'

RSpec.describe Partners::Staff::AdminsController, type: :controller do
  let(:organisation) { build(:organisation) }
  let!(:admin) { create(:admin, organisation: organisation) }
  let(:valid_attributes) { attributes_for(:admin) }
  let(:invalid_attributes) { attributes_for(:admin, employee_id: nil) }
  let(:valid_session) { {} }

  login_admin

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'redirects to edit' do
      get :show, params: { id: admin.to_param }, session: valid_session
      expect(response).to redirect_to([:edit, :partners, admin])
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
      get :edit, params: { id: admin.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Admin' do
        expect {
          post :create, params: { admin: valid_attributes }, session: valid_session
        }.to change(Admin, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: { admin: valid_attributes }, session: valid_session
        expect(response).to redirect_to(%i[partners admins])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { admin: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { first_name: 'Foo' } }

      it 'updates the requested partners_staff' do
        put :update, params: { id: admin.to_param, admin: new_attributes }, session: valid_session
        admin.reload
        expect(admin.first_name).to eq(new_attributes[:first_name])
      end

      it 'redirects to the index' do
        put :update, params: { id: admin.to_param, admin: valid_attributes }, session: valid_session
        expect(response).to redirect_to(%i[partners admins])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: admin.to_param, admin: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested admin' do
      expect {
        delete :destroy, params: { id: admin.to_param }, session: valid_session
      }.to change(Admin, :count).by(-1)
    end

    it 'redirects to the admins list' do
      delete :destroy, params: { id: admin.to_param }, session: valid_session
      expect(response).to redirect_to(%i[partners admins])
    end
  end

end
