# == Schema Information
#
# Table name: category_updates
#
#  id           :bigint(8)        not null, primary key
#  category_id  :bigint(8)
#  question_ids :integer          default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_category_updates_on_category_id   (category_id)
#  index_category_updates_on_question_ids  (question_ids) USING gin
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

class CategoryUpdate < ApplicationRecord
  belongs_to :category

  validates :category, :question_ids, presence: true

  cache_warm_attributes :title, :photo, :questions

  def title
    Rails.cache.fetch [self, category, :title] do
      if category.title.downcase == 'general' && category.has_parent?
        return category.parent.title
      end
      category.title
    end
  end

  def photo
    Rails.cache.fetch [self, category, :photo] do
      category.photo
    end
  end

  def questions
    Rails.cache.fetch [self, :questions] do
      Question.where(id: question_ids)
    end
  end
end
