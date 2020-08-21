Types::TokenType = GraphQL::ObjectType.define do
  name 'Token'
  field :token, types.String
end
