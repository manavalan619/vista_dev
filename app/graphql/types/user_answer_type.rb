Types::UserAnswerType = GraphQL::ObjectType.define do
  name 'UserAnswer'
  field :id, types.ID
  field :userId, types.ID, property: :user_id
  field :questionId, types.ID, property: :question_id
  field :note, types.String
  field :values, Types::JsonType
  field :createdAt, types.String, property: :created_at
  field :updatedAt, types.String, property: :updated_at
  field :linkedCategories do
    type types[Types::CategoryType]

    resolve lambda { |obj, args, ctx|
      conditions = [obj.values].flatten.map do |answer|
        {
          question_id: obj.question_id,
          answer: answer
        }
      end

      Category.where('visibility_conditions @> ?', conditions.to_json)
    }
  end
end
