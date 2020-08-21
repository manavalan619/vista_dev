class Feed < ActiveModelSerializers::Model
  attributes :articles, :interactions, :category_updates, :videos
end
