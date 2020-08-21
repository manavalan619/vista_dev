# == Schema Information
#
# Table name: member_requests
#
#  id                     :bigint(8)        not null, primary key
#  user_id                :bigint(8)
#  branch_id              :bigint(8)
#  member_request_type_id :bigint(8)
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  last_message_sent_at   :datetime
#
# Indexes
#
#  index_member_requests_on_branch_id               (branch_id)
#  index_member_requests_on_member_request_type_id  (member_request_type_id)
#  index_member_requests_on_user_id                 (user_id)
#

FactoryBot.define do
  factory :member_request do
    member_request_type
  end
end
