require 'rails_helper'

RSpec.describe 'Api::V1::FeedController', type: :request do
  let(:user) { create(:user) }
  let(:json) { JSON.parse(subject.body) }
  subject { response }

  describe 'GET /api/v1/questions' do
    before { get api_v1_feed_index_url(subdomain: 'api'), headers: auth_headers(user) }

    it { is_expected.to have_http_status(200) }
    it { expect(json).to include('articles') }
    it { expect(json['articles']).to be_an_instance_of(Array) }
    it { expect(json).to include('interactions') }
    it { expect(json['interactions']).to be_an_instance_of(Array) }
  end
end
