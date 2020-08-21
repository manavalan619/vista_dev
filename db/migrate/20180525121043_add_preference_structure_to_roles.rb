class AddPreferenceStructureToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :preference_structure, :jsonb, default: { left: [], right: [] }
  end
end
