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

class Video < ApplicationRecord
  include HasContentCategories
  acts_as_paranoid column: :archived_at

  has_many :video_content_categories, dependent: :destroy
  has_many :content_categories, through: :video_content_categories
  belongs_to :vista_admin
  belongs_to :organisation, optional: true

  validates :name, :description, :content_categories, presence: true
  validates :url, format: { with: /\A*.mp4/, message: 'must be an .mp4 file' }, presence: true
  validates :description, length: { maximum: 100 }

  scope :in_organisation, -> (organisation) { where(organisation_id: organisation) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :for_vista, -> { where(organisation: nil) }
  scope :search, -> (term) { where('videos.name ILIKE ? OR videos.description ILIKE ?', "%#{term.strip}%", "%#{term.strip}%") }
  scope :published, -> { where(published: true) }

  before_save :check_published_status
  before_save :extract_platform_id, if: :url_changed?

  private

  def check_published_status
    if published_changed? && published?
      self.published_at = Time.now
    end
  end

  # We require the ID of the video from vimeo etc, which is contained within the URL
  # e.g. https://player.vimeo.com/external/281201722.hd.mp4?s=027e0c1a0ae6a225f02c4897c96071feca47e516&profile_id=174
  # whereby 281201722 is the video ID on vimeo.
  def extract_platform_id
    match = self.url.match(/\/(\w*)\.*[\w*.]*.mp4/)
    self.platform_id = match[1] unless !match
  end
end
