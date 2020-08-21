class AddTimestampsToShares < ActiveRecord::Migration[5.2]
  def change
    add_column :shares, :requested_at, :datetime
    add_column :shares, :authorised_at, :datetime
    add_column :shares, :denied_at, :datetime
    add_column :shares, :revoked_at, :datetime
  end
end
