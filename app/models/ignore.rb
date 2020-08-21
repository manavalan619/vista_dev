# == Schema Information
#
# Table name: ignores
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_ignores_on_category_id  (category_id)
#  index_ignores_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#

class Ignore < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :category

  validates :user, :category, presence: true
end
