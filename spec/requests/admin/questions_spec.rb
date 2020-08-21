require 'rails_helper'

RSpec.describe 'Api::Admin::QuestionsController', type: :request do
  let!(:admin) { create(:vista_admin) }
  let!(:question) { create(:question, :text) }
  let(:question_params) { { question: question.attributes } }
  subject { response }

  before { host! 'admin.vista.test' }

  before { sign_in(admin) }

  describe 'GET /questions' do
    before do
      get url_for(%i[admin questions])
    end

    it { is_expected.to have_http_status(200) }
    it { expect(assigns(:questions)).to eq([question]) }
  end

  describe 'GET /questions/:id' do
    before do
      get url_for([:admin, question])
    end

    it { is_expected.to have_http_status(302) }
    it { expect(assigns(:question)).to eq(question) }
  end

  describe 'POST /questions/:id/questions' do
    context 'successful' do
      before do
        post url_for(%i[admin questions]), params: question_params
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:question)).to be_a(Question) }
    end

    context 'unsuccessful' do
      before do
        post url_for(%i[admin questions]), params: { question: { title: '' } }
      end

      it { is_expected.to have_http_status(200) }
    end
  end

  describe 'PUT /questions/:id/question' do
    context 'successful' do
      before do
        put url_for([:admin, question]), params: question_params
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:question)).to be_a(Question) }
    end

    context 'unsuccessful' do
      before do
        put url_for([:admin, question]), params: { question: { title: '' } }
      end

      it { is_expected.to have_http_status(200) }
    end
  end

  describe 'PATCH /questions/:id/question' do
    context 'successful' do
      before do
        patch url_for([:admin, question]), params: question_params
      end

      it { is_expected.to have_http_status(302) }
      it { expect(assigns(:question)).to be_a(Question) }
    end

    context 'unsuccessful' do
      before do
        patch url_for([:admin, question]), params: { question: { title: '' } }
      end

      it { is_expected.to have_http_status(200) }
      it { expect(assigns(:question)).to be_a(Question) }
    end
  end

  describe 'DELETE /questions/:id/question' do
    before do
      delete url_for([:admin, question])
    end

    it { is_expected.to have_http_status(302) }
  end
end
