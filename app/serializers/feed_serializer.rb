class FeedSerializer < ApplicationSerializer
  has_many :articles
  has_many :interactions, serializer: InteractionSerializer
  has_many :category_updates
  has_many :videos
end
