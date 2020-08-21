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

class MemberRequestMessage < ApplicationRecord
  include AASM

  belongs_to :member_request
  belongs_to :messageable, polymorphic: true

  scope :from_staff_member, -> { where(messageable_type: 'StaffMember') }
  scope :from_member, -> { where(messageable_type: 'User') }
  scope :unread, -> { where.not(status: 'read') }
  scope :read, -> { where(status: 'read') }

  # skip_notify used to determine if a graphql notification should be triggered
  # - skipped when initially creating the parent MR
  attr_accessor :skip_notify
  after_commit :notify_graphql_message_sent, :touch_member_request, on: [:create], unless: :skip_notify

  # TODO: Remove pending / sent states, read/unread are all that are required
  aasm column: 'status' do
    state :pending, initial: true
    state :sent
    state :read

    event :mark_as_read do
      transitions from: [:pending, :sent], to: :read
    end

    event :mark_as_unread do
      transitions from: [:pending, :read], to: :pending
    end

    event :mark_as_sent do
      transitions from: :pending, to: :sent
    end
  end

  def read?
    status === 'read'
  end

  private

  def notify_graphql_message_sent
    member_request.member_request_type.staff_members.pluck(:id).uniq.each do |staff_member_id|
      VistaPlatformSchema.subscriptions.trigger(
        'newMessage', {}, self, scope: staff_member_id
      )
    end
  end

  def touch_member_request
    member_request.touch(:last_message_sent_at)
  end
end
