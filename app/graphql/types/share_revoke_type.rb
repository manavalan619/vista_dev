class Types::ShareRevokeType < Types::BaseObject
  graphql_name 'ShareRevoke'

  field :user, Types::UserType, null: false
  field :revoked_at, Types::DateTimeType, null: false
end
