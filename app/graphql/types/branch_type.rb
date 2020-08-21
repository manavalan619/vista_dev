Types::BranchType = GraphQL::ObjectType.define do
  name 'Branch'
  field :id, types.ID
  field :name, types.String
  field :address, types.String
end
