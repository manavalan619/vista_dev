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

require 'rails_helper'

RSpec.describe MemberRequest, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:branch) }
    it { is_expected.to belong_to(:member_request_type) }
    it { is_expected.to have_many(:member_request_messages) }
  end
end
