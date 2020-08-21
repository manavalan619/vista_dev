class Resolvers::CreateMemberRequestMessageResolver < GraphQL::Function
  argument :body, !types.String
  argument :requestId, !types.ID

  type Types::MemberRequestMessageType

  def call(_obj, args, ctx)
    command = MemberRequestMessage::Create.call(
      member_request_id: args[:requestId],
      body: args[:body],
      staff_member: ctx[:current_user]
    )
    return command.result if command.success?
    raise GraphQL::ExecutionError, command.errors
  end
end
