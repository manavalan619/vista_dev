# == Schema Information
#
# Table name: articles
#
#  id                  :bigint(8)        not null, primary key
#  title               :string
#  content             :text
#  publish_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  notification_job_id :integer
#
# Indexes
#
#  index_articles_on_publish_at  (publish_at)
#

class Article < ApplicationRecord
  include HasContentCategories
  has_one :header_image, -> { where(photo_type: 'header_image') },
          class_name: 'Photo',
          as: :owner,
          dependent: :destroy,
          inverse_of: :owner
  has_many :photos, as: :owner, dependent: :destroy, inverse_of: :owner
  has_many :article_content_categories, dependent: :destroy
  has_many :content_categories, through: :article_content_categories

  validates :title, :content, presence: true

  accepts_nested_attributes_for :header_image,
                                reject_if: :reject_photo?,
                                allow_destroy: true

  scope :newest_first, -> { order(publish_at: :desc) }
  scope :published, -> { where('publish_at < ?', DateTime.current).newest_first }
  scope :search, ->(term) { where('articles.title ILIKE ?', "%#{term}%") }

  alias_attribute :published_at, :publish_at

  after_commit :schedule_notification, on: :update

  def header_image=(header_image)
    header_image.photo_type = 'header_image'
    super
  end

  def publish_at=(publish_at)
    super(Time.parse(publish_at.to_s).to_s)
  end

  def published?
    return false unless publish_at.present?

    publish_at < DateTime.current
  end

  def status
    return 'draft' unless publish_at.present?
    return 'published' if published?

    'pending'
  end

  # TODO: don't do this...
  def self.start_draft
    draft = new
    draft.save(validate: false)
    draft
  end

  private

  def schedule_notification
    return unless saved_change_to_publish_at?

    NewsJob.cancel(notification_job_id) if notification_job_id.present?
    job = NewsJob.set(wait_until: publish_at).perform_later
    update_columns(notification_job_id: job)
  end

  def reject_photo?(attributes)
    attributes['image'].blank? && attributes['remote_image_url'].blank?
  end
end
