# == Schema Information
#
# Table name: interactions
#
#  id              :bigint(8)        not null, primary key
#  user_id         :bigint(8)        not null
#  staff_member_id :bigint(8)
#  branch_id       :bigint(8)
#  category_id     :bigint(8)
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  type            :string           default(""), not null
#
# Indexes
#
#  index_interactions_on_branch_id        (branch_id)
#  index_interactions_on_category_id      (category_id)
#  index_interactions_on_staff_member_id  (staff_member_id)
#  index_interactions_on_type             (type)
#  index_interactions_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (staff_member_id => staff_members.id)
#  fk_rails_...  (user_id => users.id)
#

class Interaction < ApplicationRecord
  self.inheritance_column = :_type_disabled

  PARTNER_TYPES = %w[
    recommendation made_reservation booked_tickets taxi_booked
    shopping_experience_booked

    check_in_out room_upgraded taxi_ordered wake_up_call_arranged
    loyalty_programme_added additional_room_key_made portfolio_sent

    cleaned_room updated_toiletry_products refilled_minibar
    updated_minibar_with_bespoke_items temperature_set turndown_service
    water_bottles_added

    made_drink_to_preference preferred_snacks_served
    presented_some_tasting_options made_coffee_to_preference suggestions_made

    dressing_room_prepared sizes_found brand_preference_found drink_served

    bags_collected bags_delivered_to_room bags_stored

    specific_vintage_found specific_wine_found regional_choices_found
    pairing_options_suggested
  ].freeze
  MOODS = %w[happy need_some_love tired hungry hungover sad jetlagged].freeze

  belongs_to :user, touch: true
  belongs_to :staff_member, required: false
  belongs_to :branch, required: false
  belongs_to :category, touch: true, required: false

  validates :user, :type, :description, presence: true
  validates :staff_member, :branch, presence: true, if: :partner_type?
  validates :description, inclusion: { in: MOODS }, if: :mood?

  alias_attribute :date, :created_at
  alias_attribute :value, :description
  alias_attribute :values, :description
  alias_attribute :notes, :description

  scope :for_today, -> { where('DATE(created_at) = ?', Date.current) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :without_mood, -> { where.not(type: 'mood') }
  default_scope -> { newest_first }

  after_commit :notify_graphql_mood_change, if: :mood?

  def mood?
    type == 'mood'
  end

  def partner_type?
    PARTNER_TYPES.include?(type)
  end

  private

  def notify_graphql_mood_change
    user.authorised_branches.pluck(:id).each do |branch_id|
      VistaPlatformSchema.subscriptions.trigger(
        'moodChanged', {}, self, scope: branch_id
      )
    end
  end
end
