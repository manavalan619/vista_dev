class AddVistaPartnerToBranches < ActiveRecord::Migration[5.2]
  def change
    add_column :branches, :vista_partner, :boolean, default: false
    add_index :branches, :vista_partner
  end
end
