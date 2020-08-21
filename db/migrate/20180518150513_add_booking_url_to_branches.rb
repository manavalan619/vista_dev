class AddBookingUrlToBranches < ActiveRecord::Migration[5.2]
  def change
    add_column :branches, :booking_url, :string
  end
end
