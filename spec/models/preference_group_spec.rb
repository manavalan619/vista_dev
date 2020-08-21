# == Schema Information
#
# Table name: preference_groups
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  question_ids :integer          default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_preference_groups_on_question_ids  (question_ids) USING gin
#

require 'rails_helper'

RSpec.describe PreferenceGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
