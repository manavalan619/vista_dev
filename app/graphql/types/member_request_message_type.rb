Types::MemberRequestMessageType = GraphQL::ObjectType.define do
  name 'MemberRequestMessage'
  field :id, types.ID
  field :messageable, Types::MessageableType
  field :body, types.String

  field :memberRequest do
    type Types::MemberRequestType
    resolve -> (obj, _args, _ctx) { obj.member_request }
  end

  field :senderName do
    type types.String
    resolve -> (obj, _args, _ctx) { obj.messageable.name }
  end
  field :senderType do
    type types.String
    resolve -> (obj, _args, _ctx) { obj.messageable_type }
  end
  field :createdAt do
    type Types::DateTimeType
    resolve -> (obj, _args, _ctx) { obj.created_at }
  end
end
