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

class PartnerCategorySerializer < ApplicationSerializer
  attributes :id, :title, :position

  has_one :photo
end
