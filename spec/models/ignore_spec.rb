# == Schema Information
#
# Table name: ignores
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)
#  category_id :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_ignores_on_category_id  (category_id)
#  index_ignores_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Ignore, type: :model do
  subject { build(:ignore) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:category) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :category }
end
