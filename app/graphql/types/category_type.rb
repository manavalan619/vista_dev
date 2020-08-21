Types::CategoryType = GraphQL::ObjectType.define do
  name 'Category'
  field :id, types.ID
  field :title, types.String
  field :description, types.String
  field :ancestry, types.String
  field :position, types.Int

  field :questions do
    type types[Types::QuestionType]
    resolve ->(obj, _args, _ctx) { obj.questions }
  end

  field :categories do
    type types[Types::CategoryType]
    resolve ->(obj, _args, _ctx) { obj.children.with_questions }
  end

  field :questionsCount do
    type types.Int
    resolve ->(obj, _args, _ctx) { obj.questions_count }
  end

  field :answeredQuestionsCount do
    type types.Int
    argument :userId, types.ID
    resolve lambda { |obj, args, _ctx|
      user_id = args[:userId]
      user = User.find(user_id)
      obj.answered_questions_count(user)
    }
  end
end
