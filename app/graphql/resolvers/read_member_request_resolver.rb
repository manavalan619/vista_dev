class Resolvers::ReadMemberRequestResolver < GraphQL::Function
  argument :memberRequestId, !types.ID

  type Types::MemberRequestType

  # Called by the partner app GraphQL Mutation (so
  # always a Staff Member marking Member messages as read)
  def call(_obj, args, ctx)
    command = MemberRequests::MarkAsRead.call(
      member_request_id: args[:memberRequestId],
      staff_member: ctx[:current_user]
    )

    return command.result if command.success?
    raise GraphQL::ExecutionError, command.errors
  end
end
