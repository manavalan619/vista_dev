# == Schema Information
#
# Table name: role_assignments
#
#  id              :bigint(8)        not null, primary key
#  role_id         :bigint(8)
#  staff_member_id :bigint(8)
#  archived_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_role_assignments_on_archived_at      (archived_at)
#  index_role_assignments_on_role_id          (role_id)
#  index_role_assignments_on_staff_member_id  (staff_member_id)
#  index_unarchived_staff_member_role         (role_id,staff_member_id,archived_at)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#  fk_rails_...  (staff_member_id => staff_members.id)
#

class RoleAssignment < ApplicationRecord
  belongs_to :role
  belongs_to :staff_member
end
