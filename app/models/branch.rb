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

class Branch < ApplicationRecord
  acts_as_paranoid column: :archived_at
  # NB: handled manually as IIRC there was an issue with acts_as_paranoid
  # after_destroy :destroy_staff

  belongs_to :business_unit
  has_one :organisation, through: :business_unit
  has_one :photo, as: :owner, dependent: :destroy, inverse_of: :owner
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
  has_many :staff_assignments, as: :target, dependent: :destroy
  has_many :staff_members, through: :staff_assignments, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :users, -> { merge(Share.authorised) }, through: :shares
  has_many :branch_categorisations, dependent: :destroy
  has_many :categories, through: :branch_categorisations, source: :partner_category
  has_many :interactions, dependent: :destroy
  has_many :roles, through: :business_unit
  has_many :check_ins, dependent: :destroy
  has_many :member_requests
  # TODO: i think this is wrong:
  has_many :member_request_messages, as: :messageable

  acts_as_mappable through: :address

  validates :name, presence: true
  validates :business_unit, presence: true
  validates :address, presence: true

  alias_attribute :about, :branch_info
  alias_attribute :title, :name

  delegate :latitude, :longitude, to: :address, allow_nil: true

  accepts_nested_attributes_for :photo, reject_if: :reject_photo?, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  cache_warm_attributes :category_titles

  scope :alphabetical, -> { order(name: :asc) }
  scope :in_category, -> (category) {
    joins(:categories).where(partner_categories: { id: category })
  }
  scope :in_city, -> (city) { joins(:address).where(addresses: { city_id: city }) }
  scope :ordered_by_distance, -> (coords) { joins(:address).by_distance(origin: [coords["latitude"], coords["longitude"]]) }
  scope :vista_partners, -> { where(vista_partner: true) }
  scope :search, -> (term) { where('branches.name ILIKE ?', "%#{term}%") }

  after_commit :notify_users, on: :create

  def category_titles
    Rails.cache.fetch [self, :categories] do
      categories.map(&:title)
    end
  end

  def destroy_staff
    # TODO: run this in a background job
    staff_members.destroy_all
  end

  def staff_members_and_admins
    staff_members + organisation.admins
  end

  # TODO: improve the SQL, currently 3 separate queries
  def staff_members_and_admins_for_role(role)
    staff_members.only_staff_members.with_role(role) +
      staff_members.only_branch_managers + organisation.admins
  end

  def staff_members_for_role(role)
    staff_members.only_staff_members.with_role(role) +
      staff_members.only_branch_managers
  end

  private

  def reject_photo?(attributes)
    attributes['image'].blank?
  end

  def notify_users
    NewsJob.perform_later
  end
end
