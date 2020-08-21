# == Schema Information
#
# Table name: partner_categories
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  position   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_partner_categories_on_position  (position)
#

class PartnerCategory < ApplicationRecord
  include HasPhoto

  default_scope -> { reorder(position: :asc) }

  before_create :set_position
  after_commit :update_position, on: :create

  has_many :branch_categorisations, dependent: :destroy
  has_many :branches, through: :branch_categorisations

  def to_s
    title
  end

  private

  def set_position
    return if position.present?
    self.position = (PartnerCategory.maximum(:position) || 0) + 1
  end

  def update_position
    categories = PartnerCategory.where.not(id: id).where('position >= ?', position)
    PartnerCategory.transaction do
      categories.each { |c| PartnerCategory.increment_counter(:position, c.id) }
    end
  end
end
