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

class CategoryUpdateSerializer < ActiveModel::Serializer
  attributes :id, :category_id, :question_ids, :title, :created_at

  has_one :photo
end
