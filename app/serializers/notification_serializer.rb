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

class NotificationSerializer < ApplicationSerializer
  attributes :id, :response, :read_at
  attribute :human_type, key: :type
  attribute :created_at, key: :date

  has_one :trackable, key: :object
end
