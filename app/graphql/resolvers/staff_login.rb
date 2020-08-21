class Resolvers::StaffLogin < GraphQL::Function
  argument :employee_id, !types.String
  argument :pin, !types.String

  type Types::TokenType

  def call(_obj, args, ctx)
    command = StaffMember::Staff::Authenticate.call(
      organisation: ctx[:current_organisation],
      employee_id: args[:employee_id],
      pin: args[:pin]
    )
    if command.success?
      user = command.result
      token = AuthenticationToken.create_and_return_staff_token(user, ctx[:request])
      OpenStruct.new(token: token)
    else
      raise GraphQL::ExecutionError, command.errors[:account].join(', ')
    end
  end
end
