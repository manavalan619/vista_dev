Types::MoodType = GraphQL::ObjectType.define do
  name 'Mood'
  field :userId, types.ID, property: :user_id
  field :description, types.String, property: :description
  field :user, Types::UserType
end
