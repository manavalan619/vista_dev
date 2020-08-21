# == Schema Information
#
# Table name: article_content_categories
#
#  id                  :bigint(8)        not null, primary key
#  article_id          :bigint(8)
#  content_category_id :bigint(8)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_article_categories                                 (content_category_id,article_id)
#  index_article_content_categories_on_article_id           (article_id)
#  index_article_content_categories_on_content_category_id  (content_category_id)
#

FactoryBot.define do
  factory :article_content_category do
    
  end
end
