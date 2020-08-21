# == Schema Information
#
# Table name: content_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContentCategory < ApplicationRecord
  has_many :article_content_categories, dependent: :destroy
  has_many :articles, through: :article_content_categories

  has_many :video_content_categories, dependent: :destroy
  has_many :videos, through: :video_content_categories
end
