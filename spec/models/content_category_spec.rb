# == Schema Information
#
# Table name: content_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ContentCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
