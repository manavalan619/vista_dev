class Resolvers::CreateInteractionResolver < GraphQL::Function
  argument :type, !types.String
  argument :notes, !types.String
  argument :userId, !types.ID
  argument :memberRequestId, types.ID

  type Types::InteractionType

  def call(_obj, args, ctx)
    command = Interactions::Create.call(
      user_id: args[:userId],
      type: args[:type],
      notes: args[:notes],
      staff_member: ctx[:current_user],
      branch: ctx[:current_branch]
    )

    if command.success?
      # Create final message if memberRequestId
      if args[:memberRequestId]
        MemberRequests::Finalise.call(
          member_request_id: args[:memberRequestId],
          staff_member: ctx[:current_user],
          interaction_id: command.result.id,
        )
      end

      return command.result
    end
    raise GraphQL::ExecutionError, command.errors
  end
end
