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

class MemberRequestSerializer < ApplicationSerializer
  attributes :id, :display_name, :request_type, :read, :updated_at, :status, :branch_id
  has_many :member_request_messages

  def member_request_messages
    if instance_options[:limit_messages]
      object.member_request_messages.order('created_at ASC').last(1)
    else
      object.member_request_messages.order('created_at ASC')
    end
  end

  def display_name
    if current_user
      display_for_member
    else
      object.user.name
    end
  end

  def display_for_member
    if object.member_request_messages.where(messageable_type: 'StaffMember').count > 0
      staff_member_name
    else
      placeholder_name
    end
  end

  def placeholder_name
    'Currently unassigned'
  end

  def staff_member_name
    object.member_request_messages.from_staff_member&.last&.messageable&.name
  end

  def request_type
    object.member_request_type.name
  end

  def read
    if current_user
      object.member_request_messages.from_staff_member.unread.count === 0
    else
      object.member_request_messages.from_member.unread.count === 0
    end
  end
end
