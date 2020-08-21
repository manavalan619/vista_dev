Types::SubscriptionType = GraphQL::ObjectType.define do
  name 'Subscription'

  field :shareChanged do
    type Types::ShareType
    description 'A user shared/revoked their profile'
    subscription_scope :current_branch_id
  end

  field :moodChanged do
    type Types::MoodType
    description 'A user updated their mood'
    subscription_scope :current_branch_id
  end

  field :newMessage do
    type Types::MemberRequestMessageType
    description 'A user has sent a new message'
    subscription_scope :current_user_id
  end

  field :newMemberRequest do
    type Types::MemberRequestType
    description 'A user has submitted a member request'
    subscription_scope :current_user_id
  end

  field :requestCountChanged do
    type Types::MemberRequestType
    description 'A users request count has changed for a branch'
    subscription_scope :current_branch_id
  end
end
