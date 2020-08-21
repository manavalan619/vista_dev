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

class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :owner, polymorphic: true, touch: true

  validates :owner, :image, presence: true

  cache_warm_attributes :preview_data

  def safe_recreate_versions!
    image.cache_stored_file!
    image.retrieve_from_cache!(image.cache_name)
    image.recreate_versions!
    save!
  end
  alias recreate_versions! safe_recreate_versions!
  alias safe_recreate_versions safe_recreate_versions!
  alias recreate_versions safe_recreate_versions!

  def preview_data
    Rails.cache.fetch([self, :preview_data]) do
      return nil unless image.present?
      "data:image/jpg;base64,#{Base64.strict_encode64(image.preview.read)}"
    end
  rescue Aws::S3::Errors::NoSuchKey => exception
    Raven.capture_exception(exception)
    nil
  end
end
