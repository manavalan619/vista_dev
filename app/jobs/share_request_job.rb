class ShareRequestJob < ApplicationJob
  queue_as :default

  discard_on ActiveJob::DeserializationError

  def perform(branch, member_ids = [])
    authorised_ids = branch.users.in_member_ids(member_ids).map(&:member_id)

    unauthorised_ids = member_ids - authorised_ids

    unauthorised_user_ids = User.in_member_ids(unauthorised_ids).pluck(:id)

    unauthorised_user_ids.each do |user_id|
      Share::Request.call(branch: branch, user: user_id, via: 'proximity')
    end
  end
end
