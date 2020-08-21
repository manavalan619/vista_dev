Types::MemberRequestTypeType = GraphQL::ObjectType.define do
  name 'MemberRequestTypeType'
  field :id, types.ID
  field :business_unit, Types::BusinessUnitType
  field :name, types.String
end
