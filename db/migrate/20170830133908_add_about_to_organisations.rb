class AddAboutToOrganisations < ActiveRecord::Migration[5.1]
  def change
    add_column :organisations, :about, :text
  end
end
