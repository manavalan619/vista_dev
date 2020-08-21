module HasPhoto
  extend ActiveSupport::Concern

  included do
    has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner

    accepts_nested_attributes_for :photo, reject_if: :reject_photos?
  end

  def reject_photos?(attributes)
    attributes['image'].blank? && attributes['remote_image_url'].blank?
  end
end
