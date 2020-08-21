require 'rails_helper'

RSpec.describe Partners::Staff::StaffMembersController, type: :controller do
  let(:organisation) { build(:organisation) }
  let!(:staff_member) { create(:staff_member, organisation: organisation) }
  let(:branch) { organisation.branches.first || create(:branch, organisation: organisation) }
  let(:valid_attributes) do
    attributes_for(:staff_member, assigned_branch_ids: [branch.id])
  end
  let(:invalid_attributes) { attributes_for(:staff_member, employee_id: nil) }
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
      get :show, params: { id: staff_member.to_param }, session: valid_session
      expect(response).to redirect_to([:edit, :partners, staff_member])
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
      get :edit, params: { id: staff_member.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new StaffMember' do
        expect {
          post :create, params: { staff_member: valid_attributes }, session: valid_session
        }.to change(StaffMember, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: { staff_member: valid_attributes }, session: valid_session
        expect(response).to redirect_to(%i[partners staff_members])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { staff_member: invalid_attributes }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { first_name: 'Foo' } }

      it 'updates the requested staff_member' do
        put :update, params: {
          id: staff_member.to_param, staff_member: new_attributes
        }, session: valid_session
        staff_member.reload
        expect(staff_member.first_name).to eq(new_attributes[:first_name])
      end

      it 'redirects to the index' do
        put :update, params: {
          id: staff_member.to_param, staff_member: valid_attributes
        }, session: valid_session
        expect(response).to redirect_to(%i[partners staff_members])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {
          id: staff_member.to_param, staff_member: invalid_attributes
        }, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested staff_member' do
      expect {
        delete :destroy, params: { id: staff_member.to_param }, session: valid_session
      }.to change(StaffMember, :count).by(-1)
    end

    it 'redirects to the staff_member_staff_members list' do
      delete :destroy, params: { id: staff_member.to_param }, session: valid_session
      expect(response).to redirect_to(%i[partners staff_members])
    end
  end
end
