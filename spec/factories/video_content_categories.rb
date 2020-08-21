# == Schema Information
#
# Table name: video_content_categories
#
#  id                  :bigint(8)        not null, primary key
#  video_id            :bigint(8)
#  content_category_id :bigint(8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_video_categories                                 (content_category_id,video_id)
#  index_video_content_categories_on_content_category_id  (content_category_id)
#  index_video_content_categories_on_video_id             (video_id)
#

FactoryBot.define do
  factory :video_content_category do
    
  end
end
