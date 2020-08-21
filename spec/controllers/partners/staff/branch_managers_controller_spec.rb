require 'rails_helper'

RSpec.describe Partners::Staff::BranchManagersController, type: :controller do
  let(:organisation) { build(:organisation) }
  let!(:branch_manager) { create(:branch_manager, organisation: organisation) }
  let(:branch) do
    organisation.branches.first || create(:branch, organisation: organisation)
  end
  let(:valid_attributes) do
    attributes_for(:branch_manager, assigned_branch_ids: [branch.id])
  end
  let(:invalid_attributes) { attributes_for(:branch_manager, employee_id: nil) }
  let(:valid_session) { {} }

  login_admin

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: branch_manager.to_param }, session: valid_session
      expect(response).to redirect_to([:edit, :partners, branch_manager])
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
      get :edit, params: { id: branch_manager.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new BranchManager' do
        expect {
          post :create, params: { branch_manager: valid_attributes }, session: valid_session
        }.to change(BranchManager, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: { branch_manager: valid_attributes }, session: valid_session
        expect(response).to redirect_to(%i[partners branch_managers])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { branch_manager: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { first_name: 'Foo' } }

      it 'updates the requested branch_manager' do
        put :update, params: {
          id: branch_manager.to_param, branch_manager: new_attributes
        }, session: valid_session
        branch_manager.reload
        expect(branch_manager.first_name).to eq(new_attributes[:first_name])
      end

      it 'redirects to the index' do
        put :update, params: {
          id: branch_manager.to_param, branch_manager: valid_attributes
        }, session: valid_session
        expect(response).to redirect_to(%i[partners branch_managers])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {
          id: branch_manager.to_param, branch_manager: invalid_attributes
        }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested branch_manager' do
      expect {
        delete :destroy, params: { id: branch_manager.to_param }, session: valid_session
      }.to change(BranchManager, :count).by(-1)
    end

    it 'redirects to the branch_manager_branch_managers list' do
      delete :destroy, params: { id: branch_manager.to_param }, session: valid_session
      expect(response).to redirect_to(%i[partners branch_managers])
    end
  end
end
