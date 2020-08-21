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

class MemberRequest < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :branch
  belongs_to :member_request_type
  has_many :member_request_messages, dependent: :destroy

  # So a MR can be created with an initial message:
  accepts_nested_attributes_for :member_request_messages

  scope :for_branch, -> (branch_id) { where(branch_id: branch_id) }
  scope :for_member, -> (member_id) { where(user_id: member_id) }
  scope :in_types, -> (request_types) { where(member_request_type: request_types) }
  scope :in_status, -> (status) { where(status: status) }
  scope :search, lambda { |term|
    joins(:user)
      .joins(:member_request_type)
      .where('users.first_name ILIKE :t OR users.last_name ILIKE :t
             OR member_request_types.name ILIKE :t', t: "%#{term}%")
  }
  scope :with_message, -> (message_id) { includes(:member_request_messages).where(member_request_messages: { id: message_id }) }

  after_commit :notify_graphql_request_created, on: [:create]
  after_commit :notify_graphql_request_updated, on: [:update]

  aasm column: 'status' do
    state :open, initial: true
    state :pending
    state :closed

    event :mark_as_pending do
      transitions from: [:open, :closed], to: :pending
    end

    event :mark_as_closed do
      transitions from: [:open, :pending], to: :closed
    end

    event :mark_as_open do
      transitions from: [:closed, :pending], to: :open
    end
  end

  def mark_as_unread
    member_request_messages.from_member.last.mark_as_unread!
  end

  private

  def notify_graphql_request_created
    member_request_type.staff_members.pluck(:id).uniq.each do |staff_member_id|
      VistaPlatformSchema.subscriptions.trigger(
        'newMemberRequest', {}, self, scope: staff_member_id
      )
    end

    VistaPlatformSchema.subscriptions.trigger(
      'requestCountChanged', {}, self, scope: branch_id
    )
  end

  def notify_graphql_request_updated
    if self.member_request_type_id_previously_changed?
      # Notify any SM that couldn't previously see this MR that it's available
      notify_graphql_request_created
    elsif self.status_previously_changed? && self.status === 'closed'
      # Request has been closed, update counts for subscribers
      VistaPlatformSchema.subscriptions.trigger(
        'requestCountChanged', {}, self, scope: branch_id
      )
    end
  end
end
