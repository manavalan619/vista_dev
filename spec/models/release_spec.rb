# == Schema Information
#
# Table name: releases
#
#  id         :bigint(8)        not null, primary key
#  file       :string
#  status     :string           default("queued")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Release, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
