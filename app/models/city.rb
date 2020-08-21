# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#
# Indexes
#
#  index_cities_on_status  (status)
#

class City < ApplicationRecord
  include HasPhoto

  STATUSES = %w[enabled disabled coming_soon].freeze

  default_scope -> { reorder(name: :asc) }

  validates :name, presence: true
  validates :photo, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }

  scope :not_disabled, -> { where.not(status: 'disabled') }

  def to_s
    name
  end
end
