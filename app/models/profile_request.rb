# == Schema Information
#
# Table name: profile_requests
#
#  id         :bigint(8)        not null, primary key
#  branch_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_profile_requests_on_branch_id_and_user_id  (branch_id,user_id) UNIQUE
#

class ProfileRequest < ApplicationRecord
  belongs_to :branch
  belongs_to :user
end
