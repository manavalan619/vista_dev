class AddOrganisationToRoles < ActiveRecord::Migration[5.1]
  def change
    add_reference :roles, :organisation, foreign_key: true
  end
end
