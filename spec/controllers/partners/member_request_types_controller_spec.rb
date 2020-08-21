require 'rails_helper'

RSpec.describe Partners::MemberRequestTypesController, type: :controller do
  let(:organisation) { create(:organisation) }
  let(:business_unit) { create(:business_unit, organisation: organisation) }
  let(:request_type) { create(:member_request_type, business_unit: business_unit) }
  let(:valid_attributes) { attributes_for(:member_request_type, business_unit_id: business_unit.id) }
  let(:invalid_attributes) { attributes_for(:member_request_type, name: nil, business_unit_id: business_unit.id) }
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

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { business_unit_id: business_unit.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { business_unit_id: business_unit, id: request_type.to_param }, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new member request type' do
        expect {
          post :create, params: {
            business_unit_id: business_unit, member_request_type: valid_attributes
          }, session: valid_session
        }.to change(MemberRequestType, :count).by(1)
      end

      it 'redirects to the index' do
        post :create, params: {
          business_unit_id: business_unit, member_request_type: valid_attributes
        }, session: valid_session
        expect(response).to redirect_to([:partners, business_unit, :member_request_types])
      end
    end

    context 'with invalid params' do
      it "displays the 'new' template)" do
        post :create, params: {
          business_unit_id: business_unit, member_request_type: { name: nil }
        }, session: valid_session
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'New type' } }

      it 'updates the requested type' do
        put :update, params: {
          business_unit_id: business_unit, id: request_type.to_param, member_request_type: new_attributes
        }, session: valid_session
        request_type.reload
        expect(request_type.name).to eq new_attributes[:name]
      end

      it 'redirects to the index' do
        put :update, params: {
          business_unit_id: business_unit, id: request_type.to_param, member_request_type: valid_attributes
        }, session: valid_session
        expect(response).to redirect_to([:partners, business_unit, :member_request_types])
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {
          business_unit_id: business_unit, id: request_type.to_param, member_request_type: invalid_attributes
        }, session: valid_session
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested type' do
      request_type = create(:member_request_type, business_unit: business_unit)
      expect {
        delete :destroy, params: {
          business_unit_id: business_unit.to_param,
          id: request_type.to_param
        }, session: valid_session
      }.to change(MemberRequestType, :count).by(-1)
    end

    it 'redirects to the request types list' do
      delete :destroy, params: {
        business_unit_id: business_unit.to_param,
        id: request_type.to_param,
      }, session: valid_session
      expect(response).to redirect_to([:partners, business_unit, :member_request_types])
    end
  end
end
