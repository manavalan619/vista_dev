class ChangeMemberRequestAssociations < ActiveRecord::Migration[5.2]
  def change
    rename_column :member_requests, :business_unit_id, :branch_id
  end
end
