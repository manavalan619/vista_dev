# == Schema Information
#
# Table name: member_request_messages
#
#  id                :bigint(8)        not null, primary key
#  body              :text
#  status            :string
#  member_request_id :bigint(8)
#  messageable_id    :integer
#  messageable_type  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_member_request_messages_on_member_request_id  (member_request_id)
#  request_message_index                               (messageable_type,messageable_id)
#

class MemberRequestMessageSerializer < ApplicationSerializer
  attributes :id, :body, :status, :created_at, :sender_name, :sender_type

  def sender_name
    object.messageable.name
  end

  def sender_type
    object.messageable_type
  end
end
