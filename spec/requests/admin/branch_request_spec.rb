require 'rails_helper'

RSpec.describe 'Admin::BranchesController', type: :request do
  let(:organisation) { build(:organisation) }
  let!(:branch_manager) { create(:branch_manager, organisation: organisation) }
  let!(:admin) { create(:vista_admin) }
  let!(:member) { create(:user) }
  let!(:business_unit) { create(:business_unit, organisation: organisation) }
  let(:city) { create(:city) }
  let(:branch_params) do
    {
      name: 'test',
      address_attributes: attributes_for(:address, city_id: city.id)
    }
  end
  let!(:branch) { create(:branch, business_unit: business_unit) }
  subject { response }

  before { host! 'admin.vista.test' }

  context 'as admin' do
    before { sign_in(admin) }

    describe 'GET /organisations/:organisation_id/units/:unit_id/branches' do
      before do
        get url_for([:admin, organisation, business_unit, :branches])
      end

      it { is_expected.to have_http_status(200) }
      it { expect(assigns(:branches)).to eq([branch]) }
    end

    describe 'GET /organisations/:organisation_id/units/:unit_id/branches/:id' do
      before do
        get url_for([:admin, organisation, business_unit, branch])
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'POST /organisations/:organisation_id/units/:unit_id/branches' do
      context 'successful' do
        before do
          post url_for([:admin, organisation, business_unit, :branches]),
               params: { branch: branch_params }
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:branch)).to be_a(Branch) }
      end

      context 'not successful' do
        before do
          allow_any_instance_of(Branch).to receive(:save).and_return(false)
          post url_for([:admin, organisation, business_unit, :branches]),
               params: { branch: branch_params }
        end

        it { is_expected.to have_http_status(200) }
        it { expect(assigns(:branch)).to be_a(Branch) }
      end
    end

    describe 'PUT /organisations/:organisation_id/units/:unit_id/branches/:id' do
      context 'successful' do
        before do
          put url_for([:admin, organisation, business_unit, branch]),
              params: { branch: branch_params }
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:branch)).to eq(branch) }
      end

      context 'not successful' do
        before do
          allow_any_instance_of(Branch).to receive(:save).and_return(false)
          put url_for([:admin, organisation, business_unit, branch]),
              params: { branch: branch_params }
        end

        it { is_expected.to have_http_status(200) }
        it { expect(assigns(:branch)).to eq(branch) }
      end
    end

    describe 'PATCH /organisations/:organisation_id/units/:unit_id/branches/:id' do
      context 'successful' do
        before do
          patch url_for([:admin, organisation, business_unit, branch]),
                params: { branch: branch_params }
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:branch)).to eq(branch) }
      end

      context 'not successful' do
        before do
          allow_any_instance_of(Branch).to receive(:save).and_return(false)
          patch url_for([:admin, organisation, business_unit, branch]),
                params: { branch: branch_params }
        end

        it { is_expected.to have_http_status(200) }
        it { expect(assigns(:branch)).to eq(branch) }
      end
    end

    describe 'DELETE /organisations/:organisation_id/units/:unit_id/branches/:id' do
      before do
        delete url_for([:admin, organisation, business_unit, branch])
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:branch)).to eq(branch) }
    end
  end

  context 'as member' do
    before { sign_in(member) }

    describe 'GET /organisations/:organisation_id/units/:unit_id/branches' do
      before { get url_for([:admin, organisation, business_unit, :branches]) }

      it { is_expected.to have_http_status(302) }
    end

    describe 'GET /organisations/:organisation_id/units/:unit_id/branches/:id' do
      before { get url_for([:admin, organisation, business_unit, branch]) }

      it { is_expected.to have_http_status(302) }
    end

    describe 'POST /organisations/:organisation_id/units/:unit_id/branches' do
      before do
        post url_for([:admin, organisation, business_unit, :branches]),
          params: { branch: branch_params }
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'PUT /organisations/:organisation_id/units/:unit_id/branches/:id' do
      before do
        put url_for([:admin, organisation, business_unit, branch]),
          params: { branch: branch_params }
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'PATCH /organisations/:organisation_id/units/:unit_id/branches/:id' do
      before do
        patch url_for([:admin, organisation, business_unit, branch]),
          params: { branch: branch_params }
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'DELETE /organisations/:organisation_id/units/:unit_id/branches/:id' do
      before do
        delete url_for([:admin, organisation, business_unit, branch])
      end

      it { is_expected.to have_http_status(302) }
    end
  end
end
