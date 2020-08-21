require 'rails_helper'

RSpec.describe Api::V1::FeedController, type: :controller do
  let(:content_category) { create(:content_category) }
  let(:hidden_category) { create(:content_category) }
  let(:user) { create(:user, preferences: { hidden_categories: [hidden_category.id] }) }

  before do
    allow(subject).to receive(:authenticate).and_return(true)
    allow(subject).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end

    it 'returns published videos' do
      video = create(:video, published: true)
      get :index
      expect(JSON.parse(response.body)["videos"].first["name"]).to eq video.name
    end

    context 'with content category preferences' do
      it 'should only return videos for categories the user has chosen' do
        video = create(:video, published: true, content_categories: [content_category])
        create(:video, published: true, content_categories: [hidden_category])
        get :index
        expect(JSON.parse(response.body)["videos"].first["id"]).to eq video.id
        expect(JSON.parse(response.body)["videos"].count).to eq 1
      end

      it 'should only return articles for categories the user has chosen' do
        article = create(:article, published_at: Time.now - 1.day, content_categories: [content_category])
        create(:article, published_at: Time.now - 1.day, content_categories: [hidden_category])
        get :index
        expect(JSON.parse(response.body)["articles"].first["id"]).to eq article.id
        expect(JSON.parse(response.body)["articles"].count).to eq 1
      end
    end
  end
end
