class RemovePreferenceStructureFromRoles < ActiveRecord::Migration[5.2]
  def change
    remove_column :roles, :preference_structure, :jsonb, default: { left: [], right: [] }
  end
end
