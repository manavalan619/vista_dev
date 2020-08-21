class Types::InteractionType < Types::BaseObject
  graphql_name 'Interaction'

  field :id, Integer, null: false
  field :user, Types::UserType, null: false
  field :type, String, null: false
  field :date, Types::DateType, null: false
  field :value, String, null: true
  field :staffMember, Types::StaffMemberType, null: true
end
