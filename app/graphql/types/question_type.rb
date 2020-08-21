Types::QuestionType = GraphQL::ObjectType.define do
  name 'Question'
  field :id, types.ID
  field :title, types.String
  field :kind, types.String
  field :lockingConditions, types[Types::JsonType], property: :locking_conditions
  field :userAnswer do
    type Types::UserAnswerType

    argument :userId, types.ID

    resolve lambda { |obj, args, ctx|
      obj.user_answers.find_by(user_id: args[:userId])
    }
  end
  field :allowsNote, types.Boolean, property: :allows_note
end
