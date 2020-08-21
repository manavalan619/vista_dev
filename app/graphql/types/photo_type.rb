Types::PhotoType = GraphQL::ObjectType.define do
  name 'Photo'
  field :previewUrl, types.String, property: :member_id

  field :largeUrl do
    type types.String
    resolve ->(obj, args, ctx) {
      obj.image.large.url
    }
  end

  field :thumbUrl do
    type types.String
    resolve ->(obj, args, ctx) {
      obj.image.thumb.url
    }
  end

  field :previewUrl do
    type types.String
    resolve ->(obj, args, ctx) {
      return nil unless obj.image.present?
      obj.preview_data
    }
  end
end
