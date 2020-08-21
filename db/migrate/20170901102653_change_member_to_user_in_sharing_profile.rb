class ChangeMemberToUserInSharingProfile < ActiveRecord::Migration[5.1]
  def change
    rename_column :profile_requests, :member_id, :user_id
    rename_column :shares, :member_id, :user_id
  end
end
