Types::ShareType = GraphQL::ObjectType.define do
  name 'Share'
  field :branchId, types.ID, property: :branch_id
  field :userId, types.ID, property: :user_id
  field :status, types.String
  field :via, types.String
  field :createdAt, types.String, property: :created_at
  field :updatedAt, types.String, property: :updated_at
  field :user, Types::UserType
  field :branch, Types::BranchType
  field :authorisedAt, types.String, property: :authorised_at
  field :revokedAt, types.String, property: :revoked_at
end
