Types::RoleType = GraphQL::ObjectType.define do
  name 'Role'
  field :id, types.ID
  field :name, types.String
  field :interactions, types[Types::JsonType]
  field :preferenceStructure, types[Types::JsonType], property: :preference_structure
  field :topQuestions, types[Types::JsonType], property: :top_questions_data
  # field :preferenceStructure do
  #   type ImageSourcesType
  #   description 'Image sources and dimensions'
  #   resolve -> (object, arguments, context) do
  #     OpenStruct.new(
  #       small: OpenStruct.new(
  #         height: 120,
  #         source: object.image.thumb('120x120#').url(host: 'http://192.168.0.8:9000'),
  #         width: 120
  #       ),
  #       large: OpenStruct.new(
  #         height: ((object.image_height.to_f / object.image_width.to_f) * 640).round,
  #         source: object.image.thumb('640x').url(host: 'http://192.168.0.8:9000'),
  #         width: 640
  #       )
  #     )
  #   end
  # end
end
