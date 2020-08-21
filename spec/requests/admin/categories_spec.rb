require 'rails_helper'

RSpec.describe 'Admin::CategoriesController', type: :request do
  let!(:admin) { create(:vista_admin) }
  let!(:category) { create(:category) }
  let(:category_params) { { category: { title: 'Hotels' } } }
  subject { response }

  before { host! 'admin.vista.test' }

  before { sign_in(admin) }

  describe 'GET /categories' do
    before do
      get url_for(%i[admin categories])
    end

    it { is_expected.to have_http_status(200) }
    it { expect(assigns(:categories)).to eq([category]) }
  end

  describe 'GET /categories/:id' do
    before do
      get url_for([:admin, category])
    end

    it { is_expected.to have_http_status(302) }
    it { expect(assigns(:category)).to eq(category) }
  end

  describe 'POST /categories' do
    context 'successful' do
      before do
        post url_for(%i[admin categories]), params: category_params
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:category)).to be_a(Category) }
    end

    context 'not successful' do
      before do
        allow_any_instance_of(Category).to receive(:save).and_return(false)
        post url_for(%i[admin categories]), params: category_params
      end

      it { is_expected.to have_http_status(200) }
      it { expect(assigns(:category)).to be_a(Category) }
    end
  end

  describe 'PUT /categories/:id' do
    context 'successful' do
      before do
        put url_for([:admin, category]), params: category_params
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:category)).to eq(category) }
    end

    context 'not successful' do
      before do
        allow_any_instance_of(Category).to receive(:save).and_return(false)
        put url_for([:admin, category]), params: category_params
      end

      it { is_expected.to have_http_status(200) }
      it { expect(assigns(:category)).to eq(category) }
    end
  end

  describe 'PATCH /categories/:id' do
    context 'successful' do
      before do
        patch url_for([:admin, category]), params: category_params
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:category)).to eq(category) }
    end

    context 'not successful' do
      before do
        allow_any_instance_of(Category).to receive(:save).and_return(false)
        patch url_for([:admin, category]), params: category_params
      end

      it { is_expected.to have_http_status(200) }
      it { expect(assigns(:category)).to eq(category) }
    end
  end

  describe 'DELETE /categories/:id' do
    before do
      delete url_for([:admin, category])
    end

    it { is_expected.to have_http_status(302) }
    it { expect(assigns(:category)).to eq(category) }
  end
end
