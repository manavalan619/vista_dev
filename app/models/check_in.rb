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

class CheckIn < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :branch

  validates :user, presence: true
  validates :branch, presence: true
  validates :arrival_date, presence: true
  validates :arrival_time_start, presence: true
  # TODO: maybe add some validation to stop multiple checkins

  scope :earliest, -> { order(arrival_date: :asc) }
  scope :future, lambda {
    earliest.where('DATE(check_ins.arrival_date) >= DATE(?)', Date.today)
  }
  scope :for_branch, ->(branch) { where(branch: branch) }
end
