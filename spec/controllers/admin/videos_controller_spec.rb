require 'rails_helper'

RSpec.describe Admin::VideosController, type: :controller do
  login_vista_admin

  describe 'GET #index' do
    before do
      @video = create(:video, name: 'Test video title', description: 'A test description goes here')
    end

    it 'returns a success response' do
      get :index, session: {}
      expect(response).to be_success
    end

    context 'when filtering by organisation' do
      it 'should return videos for the given organisation' do
        get :index, params: { organisation: @video.organisation_id }
        expect(assigns(:videos)).to eq [@video]
      end
    end

    context 'when searching by a matching term in ' do
      it 'should return the matching videos' do
        get :index, params: { q: 'st video ti' }
        expect(assigns(:videos)).to eq [@video]
      end
    end
  end

  describe 'POST #create' do
    let(:content_category) { create(:content_category) }
    let(:valid_params) {
      {
        video: {
          url: 'some/url/here.mp4',
          name: 'Test Video',
          description: 'Description',
          content_category_ids: [content_category.id],
          published: false
        }
      }
    }

    let(:invalid_params) {
      {
        video: {
          url: 'only/a/url.mp4'
        }
      }
    }

    context 'with valid params' do
      it 'should create a Video entry' do
        expect {
          post :create, params: valid_params, session: {}
        }.to change(Video, :count).by(1)
      end

      it 'should redirect back to the index' do
        post :create, params: valid_params, session: {}
        expect(response).to redirect_to(admin_videos_path)
      end
    end

    context 'with invalid params' do
      it 'should render the form again' do
        post :create, params: invalid_params, session: {}
        expect(response).to render_template :new
      end

      it 'should not create a video' do
        expect {
          post :create, params: invalid_params, session: {}
        }.to change(Video, :count).by(0)
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_params) {
      {
        url: 'some/new/url/here.mp4',
        name: 'Updated Test Video',
      }
    }

    let(:invalid_params) {
      {
        url: 'invalid/video/url/'
      }
    }

    before do
      @video = create(:video, url: 'a/valid/url.mp4')
    end

    context 'with valid params' do
      it 'updates the video' do
        put :update, params: { id: @video.to_param, video: valid_params }, session: {}
        @video.reload
        expect(@video.name).to eq 'Updated Test Video'
      end

      it 'redirects to the video index' do
        put :update, params: { id: @video.to_param, video: valid_params }, session: {}
        expect(response).to redirect_to admin_videos_path
      end
    end

    context 'with invalid params' do
      before(:each) do
        put :update, params: { id: @video.to_param, video: invalid_params }, session: {}
      end

      it 'does not update the video' do
        @video.reload
        expect(@video.url).to eq 'a/valid/url.mp4'
      end

      it 'renders the edit form' do
        expect(response).to render_template :edit
      end
    end
  end
end
