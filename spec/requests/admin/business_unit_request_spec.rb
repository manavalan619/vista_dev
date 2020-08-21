require 'rails_helper'

RSpec.describe 'Admin::BusinessUnitsController', type: :request do
  let(:organisation) { build(:organisation) }
  let!(:admin) { create(:vista_admin) }
  let!(:member) { create(:user) }
  let!(:business_unit) { create(:business_unit, organisation: organisation) }
  let(:business_unit_params) { { name: 'test' } }
  subject { response }

  before { host! 'admin.vista.test' }

  context 'as admin' do
    before { sign_in(admin) }

    describe 'GET /organisations/:organisation_id/units' do
      before { get url_for([:admin, organisation, :business_units]) }

      it { is_expected.to have_http_status(200) }
      it { expect(assigns(:business_units)).to eq([business_unit]) }
    end

    describe 'GET /organisations/:organisation_id/units/:id' do
      before do
        get url_for([:admin, organisation, business_unit])
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:business_unit)).to eq(business_unit) }
    end

    describe 'POST /organisations/:organisation_id/units' do
      context 'successful' do
        before do
          post url_for([:admin, organisation, :business_units]),
               params: { business_unit: business_unit_params }
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:business_unit)).to be_a(BusinessUnit) }
      end

      context 'not successful' do
        before do
          allow_any_instance_of(BusinessUnit).to receive(:save).and_return(false)
          post url_for([:admin, organisation, :business_units]),
               params: { business_unit: business_unit_params }
        end

        it { is_expected.to have_http_status(200) }
        it { expect(assigns(:business_unit)).to be_a(BusinessUnit) }
      end
    end

    describe 'PUT /organisations/:organisation_id/units/:id' do
      context 'successful' do
        before do
          put url_for([:admin, organisation, business_unit]),
              params: { business_unit: business_unit_params }
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:business_unit)).to eq(business_unit) }
      end

      context 'not successful' do
        before do
          allow_any_instance_of(BusinessUnit).to receive(:save).and_return(false)
          put url_for([:admin, organisation, business_unit]),
              params: { business_unit: business_unit_params }
        end

        it { is_expected.to have_http_status(200) }
        it { expect(assigns(:business_unit)).to eq(business_unit) }
      end
    end

    describe 'PATCH /organisations/:organisation_id/units/:id' do
      context 'successful' do
        before do
          patch url_for([:admin, organisation, business_unit]),
                params: { business_unit: business_unit_params }
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:business_unit)).to eq(business_unit) }
      end

      context 'not successful' do
        before do
          allow_any_instance_of(BusinessUnit).to receive(:save).and_return(false)
          patch url_for([:admin, organisation, business_unit]),
                params: { business_unit: business_unit_params }
        end

        it { is_expected.to have_http_status(200) }
        it { expect(assigns(:business_unit)).to eq(business_unit) }
      end
    end

    describe 'DELETE /organisations/:organisation_id/units/:id' do
      context 'successful' do
        before do
          delete url_for([:admin, organisation, business_unit])
        end

        it { is_expected.to have_http_status(302) }
        it { expect(assigns(:business_unit)).to eq(business_unit) }
      end
    end
  end

  context 'as member' do
    before { sign_in(member) }

    describe 'GET /organisations/:organisation_id/units' do
      before { get url_for([:admin, organisation, :business_units]) }

      it { is_expected.to have_http_status(302) }
    end

    describe 'GET /organisations/:organisation_id/units/:id' do
      before do
        get url_for([:admin, organisation, business_unit])
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'POST /organisations/:organisation_id/units' do
      before do
        post url_for([:admin, organisation, :business_units]),
             params: { business_unit: business_unit_params }
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'PUT /organisations/:organisation_id/units/:id' do
      before do
        put url_for([:admin, organisation, business_unit]),
            params: { business_unit: business_unit_params }
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'PATCH /organisations/:organisation_id/units/:id' do
      before do
        patch url_for([:admin, organisation, business_unit]),
              params: { business_unit: business_unit_params }
      end

      it { is_expected.to have_http_status(302) }
    end

    describe 'DELETE /organisations/:organisation_id/units/:id' do
      before do
        delete url_for([:admin, organisation, business_unit])
      end

      it { is_expected.to have_http_status(302) }
    end
  end
end
