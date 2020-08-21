class RenameCheckInsDateToArrivalDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :check_ins, :date, :arrival_date
  end
end
