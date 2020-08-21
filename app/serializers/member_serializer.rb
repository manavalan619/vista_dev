# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  mobile_number   :string
#  vista_member_id :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_members_on_first_name_and_last_name  (first_name,last_name) UNIQUE
#  index_members_on_vista_member_id           (vista_member_id) UNIQUE
#

class MemberSerializer < ApplicationSerializer
  attributes :id, :first_name, :last_name, :mobile_number, :vista_member_id
  attribute :errors, if: :errors_present?

  has_many :photos

  def errors_present?
    object.errors.present?
  end
end
