class Resolvers::UpdateMemberRequestResolver < GraphQL::Function
  argument :memberRequestId, !types.ID
  argument :memberRequestTypeId, types.ID
  argument :status, types.String

  type Types::MemberRequestType

  def call(_obj, args, ctx)
    command = MemberRequests::Update.call(
      member_request_id: args[:memberRequestId],
      member_request_type_id: args[:memberRequestTypeId],
      status: args[:status],
      staff_member: ctx[:current_user]
    )

    return command.result if command.success?
    raise GraphQL::ExecutionError, command.errors
  end
end
