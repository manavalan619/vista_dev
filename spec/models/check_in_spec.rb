# == Schema Information
#
# Table name: check_ins
#
#  id                 :bigint(8)        not null, primary key
#  user_id            :bigint(8)
#  branch_id          :bigint(8)
#  arrival_date       :date
#  arrival_time_start :time
#  arrival_time_end   :time
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_check_ins_on_branch_id  (branch_id)
#  index_check_ins_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (branch_id => branches.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  subject { build(:check_in) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:branch) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:arrival_date) }
  it { is_expected.to validate_presence_of(:arrival_time_start) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:branch) }
end
