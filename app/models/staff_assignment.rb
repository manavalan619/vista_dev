# == Schema Information
#
# Table name: staff_assignments
#
#  id              :bigint(8)        not null, primary key
#  staff_member_id :bigint(8)
#  target_type     :string
#  target_id       :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archived_at     :datetime
#
# Indexes
#
#  index_staff_assignments_on_archived_at                (archived_at)
#  index_staff_assignments_on_staff_member_id            (staff_member_id)
#  index_staff_assignments_on_target_type_and_target_id  (target_type,target_id)
#  index_staff_member_target_assignment                  (staff_member_id,target_id,target_type)
#  index_unarchived_staff_member_target_assignment       (staff_member_id,target_id,target_type,archived_at)
#
# Foreign Keys
#
#  fk_rails_...  (staff_member_id => staff_members.id)
#

class StaffAssignment < ApplicationRecord
  acts_as_paranoid column: :archived_at

  belongs_to :staff_member
  belongs_to :target, polymorphic: true

  validates :staff_member, presence: true
  validates :target, presence: true
end
