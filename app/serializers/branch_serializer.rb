# == Schema Information
#
# Table name: branches
#
#  id               :bigint(8)        not null, primary key
#  business_unit_id :bigint(8)
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  email            :string
#  telephone        :string
#  archived_at      :datetime
#  image            :string
#  branch_info      :string
#  booking_url      :string
#  vista_partner    :boolean          default(FALSE)
#  ratings_count    :integer          default(0)
#
# Indexes
#
#  index_branches_on_business_unit_id  (business_unit_id)
#  index_branches_on_vista_partner     (vista_partner)
#
# Foreign Keys
#
#  fk_rails_...  (business_unit_id => business_units.id)
#

class BranchSerializer < ApplicationSerializer
  attributes :id, :name, :about, :email, :latitude, :longitude, :booking_url,
             :vista_partner
  attribute :category_titles, key: :categories
  attribute :sharing_profile, if: :user?
  # Only return certain data if requesting full branch detail
  # ie. on view partner screen, not index
  attribute :member_request_types, if: :full_detail?
  has_one :check_in, if: :full_detail?

  has_one :address
  has_one :photo

  def latitude
    object.latitude.try(:to_f)
  end

  def longitude
    object.longitude.try(:to_f)
  end

  def member_request_types
    Rails.cache.fetch [object.business_unit, :member_request_types] do
      object.business_unit.member_request_types
    end
  end

  def sharing_profile
    Rails.cache.fetch [object, scope.current_user, :sharing_profile] do
      object.shares.authorised.exists?(user: scope.current_user)
    end
  end

  # TODO: check this caching works with the `future` scope
  def check_in
    Rails.cache.fetch [object, scope.current_user, Date.today, :check_in] do
      object.check_ins.future.find_by(user: scope.current_user)
    end
  end

  def user?
    scope.current_user.is_a?(User)
  end

  def full_detail?
    !!instance_options[:full_detail]
  end
end
