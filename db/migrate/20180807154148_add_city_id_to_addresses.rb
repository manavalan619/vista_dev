class AddCityIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :city, foreign_key: true, index: true
  end
end
