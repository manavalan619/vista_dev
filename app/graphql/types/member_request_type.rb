Types::MemberRequestType = GraphQL::ObjectType.define do
  name 'MemberRequest'
  field :id, types.ID
  field :user, Types::UserType
  field :branch, Types::BranchType
  field :status, types.String

  field :read do
    type types.Boolean
    resolve -> (obj, _args, _ctx) { obj.member_request_messages.from_member.unread.count === 0 }
  end

  field :updatedAt do
    type Types::DateTimeType
    resolve -> (obj, _args, _ctx) { obj.updated_at }
  end

  field :displayName do
    type types.String
    resolve -> (obj, _args, _ctx) { obj.user.name }
  end

  field :memberRequestType do
    type Types::MemberRequestTypeType
    resolve -> (obj, _args, _ctx) { obj.member_request_type }
  end

  field :memberRequestMessages do
    type types[Types::MemberRequestMessageType]
    resolve -> (obj, _args, _ctx) { obj.member_request_messages }
  end

  field :lastMessage do
    type Types::MemberRequestMessageType
    resolve -> (obj, _args, _ctx) { obj.member_request_messages.order('created_at ASC').last }
  end
end
