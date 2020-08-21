Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :staffLogin, function: Resolvers::StaffLogin.new
  field :createInteraction, function: Resolvers::CreateInteractionResolver.new
  field :updateMemberRequest, function: Resolvers::UpdateMemberRequestResolver.new
  field :sendMemberRequestMessage, function: Resolvers::SendMemberRequestMessageResolver.new
  field :readMemberRequest, function: Resolvers::ReadMemberRequestResolver.new
end
