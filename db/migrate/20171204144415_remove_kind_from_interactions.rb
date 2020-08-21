class RemoveKindFromInteractions < ActiveRecord::Migration[5.1]
  def change
    remove_column :interactions, :kind, :string
  end
end
