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

FactoryBot.define do
  factory :check_in do
    user
    branch
    arrival_date { '2018-05-09' }
    arrival_time_start { '12:06:59' }
    arrival_time_end { '12:06:59' }
  end
end
