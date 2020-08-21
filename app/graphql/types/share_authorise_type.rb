class Types::ShareAuthoriseType < Types::BaseObject
  graphql_name 'ShareAuthorise'

  field :user, Types::UserType, null: false
end
