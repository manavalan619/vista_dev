# == Schema Information
#
# Table name: videos
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  description         :text
#  url                 :string
#  published_at        :datetime
#  organisation_id     :bigint(8)
#  vista_admin_id      :bigint(8)
#  notification_job_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  published           :boolean          default(FALSE)
#  archived_at         :datetime
#  platform_id         :string
#
# Indexes
#
#  index_videos_on_organisation_id  (organisation_id)
#  index_videos_on_published        (published)
#  index_videos_on_vista_admin_id   (vista_admin_id)
#

require 'rails_helper'
require Rails.root.join "spec/concerns/has_content_categories_spec.rb"

RSpec.describe Video, type: :model do
  it_behaves_like 'has_content_categories'

  describe 'associations' do
    subject { build(:video) }


    it { is_expected.to belong_to(:vista_admin) }
    it { is_expected.to belong_to(:organisation) }
  end

  describe 'validations' do
    subject { build(:video) }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe '#newest_first' do
    let!(:video_one) { create(:video, created_at: Date.today - 1.week) }
    let!(:video_two) { create(:video, created_at: Date.today) }

    it 'should return all videos ordered by created_at' do
      expect(Video.newest_first.first).to eq video_two
    end
  end

  describe 'extracting the video ID' do
    it 'should extract the platforms video id when saving' do
      video = build(:video, url: 'https://player.vimeo.com/external/281201722.hd.mp4')
      video.save
      expect(video.platform_id).to eq '281201722'
    end
  end
end
