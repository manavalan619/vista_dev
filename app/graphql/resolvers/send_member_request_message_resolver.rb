class Resolvers::SendMemberRequestMessageResolver < GraphQL::Function
  argument :memberRequestId, !types.ID
  argument :body, types.String

  type Types::MemberRequestMessageType

  def call(_obj, args, ctx)
    command = MemberRequests::Message.call(
      member_request_id: args[:memberRequestId],
      body: args[:body],
      staff_member: ctx[:current_user]
    )

    return command.result if command.success?
    raise GraphQL::ExecutionError, command.errors
  end
end
