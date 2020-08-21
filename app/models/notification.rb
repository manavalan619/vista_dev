# == Schema Information
#
# Table name: notifications
#
#  id           :bigint(8)        not null, primary key
#  user_id      :bigint(8)
#  type         :string
#  response     :jsonb
#  object_type  :string
#  object_id    :bigint(8)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  read_at      :datetime
#  responded_at :datetime
#
# Indexes
#
#  index_notifications_on_object_type_and_object_id  (object_type,object_id)
#  index_notifications_on_read_at                    (read_at)
#  index_notifications_on_type                       (type)
#  index_notifications_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :object, polymorphic: true

  validates :user, :type, presence: true

  before_update :set_responded_at
  after_commit :schedule_push_notifications, on: :create

  # NOTE: fixes issue with AMS object naming
  alias trackable object

  scope :without_response, -> { where(response: nil) }
  scope :unread, -> { where(read_at: nil) }
  scope :newest_first, -> { order(created_at: :desc) }
  default_scope -> { newest_first }

  def human_type
    type.split('::').pop.underscore
  end

  def mark_as_read
    update(read_at: Time.current)
  end

  def self.mark_all_read
    update_all(read_at: Time.current)
  end

  def name
    case object_type
    when 'Branch'
      object.name
    when 'MemberRequestMessage'
      object.member_request.branch.name
    else
      object.name
    end
  end

  private

  def set_responded_at
    return unless response.present?
    assign_attributes(responded_at: Time.current)
  end

  def schedule_push_notifications
    PushNotificationJob.perform_later(self)
  end

  class NewMessage < Notification; end

  class ShareRequest < Notification
    RESPONSES = %w[authorised denied].freeze

    validates :response, inclusion: {
      in: RESPONSES, message: "must be one of \"#{RESPONSES.join(', ')}\""
    }, allow_nil: true

    after_commit :update_share, on: :update

    private

    def update_share
      return unless response.present? && saved_change_to_response?

      if response == 'authorised'
        Share::Authorise.call(branch: object, user: user)
      elsif response == 'denied'
        Share::Deny.call(branch: object, user: user)
      end
    end
  end

  class RatingRequest < Notification
    RESPONSES = [*1..5].freeze

    validates :response, inclusion: {
      in: RESPONSES, message: "must be one of \"#{RESPONSES.join(', ')}\""
    }, allow_nil: true

    after_commit :create_rating, on: :update

    private

    def create_rating
      return unless response.present? && saved_change_to_response?

      Rating::Rate.call(branch: object, user: user, value: response)
    end
  end
end
