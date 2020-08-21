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

require 'rails_helper'

RSpec.describe PartnerCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
