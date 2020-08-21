# == Schema Information
#
# Table name: staff_members
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  mobile_number          :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  authentication_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  organisation_id        :bigint(8)
#  type                   :string
#  employee_id            :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  suspended_at           :datetime
#  archived_at            :datetime
#  encrypted_pin          :string
#  unconfirmed_email      :string
#
# Indexes
#
#  index_staff_members_on_archived_at                      (archived_at)
#  index_staff_members_on_authentication_token             (authentication_token) UNIQUE
#  index_staff_members_on_confirmation_token               (confirmation_token) UNIQUE
#  index_staff_members_on_email                            (email)
#  index_staff_members_on_employee_id_and_organisation_id  (employee_id,organisation_id) UNIQUE
#  index_staff_members_on_organisation_id                  (organisation_id)
#  index_staff_members_on_reset_password_token             (reset_password_token) UNIQUE
#  index_staff_members_on_suspended_at                     (suspended_at)
#

class BranchManager < StaffMember
end
