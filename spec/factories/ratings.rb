# == Schema Information
#
# Table name: ratings
#
#  id         :bigint(8)        not null, primary key
#  branch_id  :bigint(8)
#  user_id    :bigint(8)
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_branch_id  (branch_id)
#  index_ratings_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :rating do
    branch { nil }
    user { nil }
    value { 1 }
  end
end
