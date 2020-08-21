# == Schema Information
#
# Table name: shares
#
#  id            :bigint(8)        not null, primary key
#  branch_id     :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string
#  via           :string
#  requested_at  :datetime
#  authorised_at :datetime
#  denied_at     :datetime
#  revoked_at    :datetime
#
# Indexes
#
#  index_shares_on_status  (status)
#  index_shares_on_via     (via)
#

class Share < ApplicationRecord
  include AASM

  # QUESTION: do we need a `denied` status or is it just deleted?
  STATUSES = %w[requested authorised revoked denied].freeze

  belongs_to :branch
  belongs_to :user, touch: true

  validates :status, inclusion: { in: STATUSES }
  validates :user_id, :branch_id, presence: true

  aasm column: 'status' do
    state :brand_spanking_new, initial: true
    state :requested
    state :authorised
    state :denied
    state :revoked

    event :request, after_commit: :create_request_notification do
      transitions from: :brand_spanking_new,
                  to: :requested,
                  after: :set_requested_at
    end

    event :authorise, after_commit: :authorised_callback do
      transitions from: %i[brand_spanking_new requested],
                  to: :authorised,
                  after: :set_authorised_at
    end

    event :deny, after_commit: :deny_notifications do
      transitions from: :requested, to: :denied, after: :set_denied_at
    end

    event :revoke, after_commit: :notify_graphql_share_change do
      transitions from: :authorised, to: :revoked, after: :set_revoked_at
    end
  end

  def self.revoke_all
    authorised.update_all(status: 'revoked', revoked_at: Time.now.utc)
  end

  private

  def set_requested_at
    self.requested_at = Time.now.utc
  end

  def set_authorised_at
    self.authorised_at = Time.now.utc
  end

  def set_denied_at
    self.denied_at = Time.now.utc
  end

  def set_revoked_at
    self.revoked_at = Time.now.utc
  end

  def authorised_callback
    notify_graphql_share_change
    schedule_reminder
    authorise_notifications
  end

  def authorise_notifications
    update_notifications('authorised')
  end

  def deny_notifications
    update_notifications('denied')
  end

  def update_notifications(response)
    Notification::ShareRequest
      .where(user: user, object: branch)
      .without_response
      .update_all(response: response, responded_at: Time.now.utc)
  end

  def create_request_notification
    Notification::ShareRequest.create(object: branch, user: user)
  end

  def schedule_reminder
    ProfileReminderJob.set(wait: 1.hour).perform_later(user)
  end

  def notify_graphql_share_change
    VistaPlatformSchema.subscriptions.trigger(
      'shareChanged', {}, self, scope: branch_id
    )
  end
end
