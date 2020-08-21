require 'rails_helper'

RSpec.describe 'Api::V1::QuestionsController', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:question) { FactoryBot.create(:question, :text) }
  subject { response }

  describe 'GET /api/v1/questions' do
    before do
      get api_v1_questions_url(subdomain: 'api'),
          headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(200) }
    it { expect(assigns(:questions)).to eq([question]) }
  end

  describe 'GET /api/v1/questions/:id' do
    before do
      get api_v1_question_url(question.id, subdomain: 'api'),
          headers: auth_headers(user)
    end

    it { is_expected.to have_http_status(200) }
    it { expect(assigns(:question)).to eq(question) }
  end
end
