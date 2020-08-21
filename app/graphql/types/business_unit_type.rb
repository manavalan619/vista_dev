Types::BusinessUnitType = GraphQL::ObjectType.define do
  name 'BusinessUnit'
  field :id, types.ID
  field :name, types.String
end
