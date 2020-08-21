# == Schema Information
#
# Table name: member_request_type_assignments
#
#  id                     :bigint(8)        not null, primary key
#  role_id                :bigint(8)
#  member_request_type_id :bigint(8)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_member_request_type_assignments_on_member_request_type_id  (member_request_type_id)
#  index_member_request_type_assignments_on_role_id                 (role_id)
#

require 'rails_helper'

RSpec.describe MemberRequestTypeAssignment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:role) }
    it { is_expected.to belong_to(:member_request_type) }
  end
end
