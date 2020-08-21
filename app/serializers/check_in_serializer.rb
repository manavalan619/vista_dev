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

class CheckInSerializer < ApplicationSerializer
  attributes :arrival_date, :arrival_time_start, :arrival_time_end

  def arrival_date
    # return nil if past?
    object.arrival_date
  end

  def arrival_time_start
    # return nil if past?
    object.arrival_time_start.try(:strftime, '%H:%M')
  end

  def arrival_time_end
    # return nil if past?
    object.arrival_time_end.try(:strftime, '%H:%M')
  end

  # private

  # def past?
  #   object.arrival_date.past?
  # end
end
