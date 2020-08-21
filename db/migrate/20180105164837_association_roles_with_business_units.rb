class AssociationRolesWithBusinessUnits < ActiveRecord::Migration[5.1]
  def change
    add_reference :roles, :business_unit, index: true, foreign_key: true
    remove_reference :roles, :organisation, index: true, foreign_key: true
  end
end
