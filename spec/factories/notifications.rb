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

FactoryBot.define do
  factory :notification do
    user

    factory :share_request_notification, class: Notification::ShareRequest do
      association :object, factory: :branch

      trait :authorised do
        response { 'authorised' }
        responded_at { Time.now.utc }
      end

      trait :denied do
        response { 'denied' }
        responded_at { Time.now.utc }
      end
    end

    factory :rating_request_notification, class: Notification::RatingRequest do
      association :object, factory: :branch

      trait :rated do
        response { [*1..5].sample }
        responded_at { Time.now.utc }
      end
    end
  end
end
