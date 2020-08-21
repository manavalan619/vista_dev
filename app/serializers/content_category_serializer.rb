# == Schema Information
#
# Table name: content_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContentCategorySerializer < ActiveModel::Serializer
  attributes :id, :name
end
