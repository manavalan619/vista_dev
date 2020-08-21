Types::PreferenceGroupType = GraphQL::ObjectType.define do
  name 'PreferenceGroup'
  field :id, types.ID
  field :title, types.String
  field :position, types.Int
  field :column, types.String
  field :questions do
    type types[Types::QuestionType]
    resolve ->(obj, _args, _ctx) { obj.questions }
  end
end
