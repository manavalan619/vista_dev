Types::StaffMemberType = GraphQL::ObjectType.define do
  name 'StaffMember'
  field :id, types.ID
  field :employeeId, types.ID, property: :employee_id
  field :name, types.String
  field :firstName, types.String, property: :first_name
  field :lastName, types.String, property: :last_name
end
