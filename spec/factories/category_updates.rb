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

FactoryBot.define do
  factory :category_update do
    category
    # question_ids { create_list(:question, 3, :text).pluck(:id) }
    question_ids { [] }
  end
end
