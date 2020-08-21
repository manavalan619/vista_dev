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

class ArticleSerializer < ApplicationSerializer
  attributes :id, :title, :content, :published_at, :content_category_ids
  attribute :type

  has_one :header_image, serializer: PhotoSerializer

  def type
    'article'
  end
end
