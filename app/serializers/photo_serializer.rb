# == Schema Information
#
# Table name: photos
#
#  id         :bigint(8)        not null, primary key
#  owner_id   :integer
#  owner_type :string
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo_type :string
#
# Indexes
#
#  index_photos_on_owner_id_and_owner_type_and_photo_type  (owner_id,owner_type,photo_type)
#  index_photos_on_photo_type                              (photo_type)
#

class PhotoSerializer < ApplicationSerializer
  attributes :id, :large_url, :thumb_url, :preview_url
  attribute :errors, if: :errors_present?

  def large_url
    object.image.large.url
  end

  def thumb_url
    object.image.thumb.url
  end

  def preview_url
    object.preview_data
  end

  def errors_present?
    object.try(:errors).try(:present?)
  end
end
