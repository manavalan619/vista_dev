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

FactoryBot.define do
  factory :share do
    association :branch
    association :user

    trait :authorised do
      status { 'authorised' }
      authorised_at {  Time.now.utc }
    end

    trait :requested do
      status { 'requested' }
      requested_at {  Time.now.utc }
    end

    trait :denied do
      status { 'denied' }
      denied_at {  Time.now.utc }
    end

    trait :revoked do
      status { 'revoked' }
      revoked_at {  Time.now.utc }
    end
  end
end
