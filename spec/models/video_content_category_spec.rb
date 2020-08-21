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

require 'rails_helper'

RSpec.describe VideoContentCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
