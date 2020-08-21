class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations do |t|
      t.string :name

      t.timestamps
    end

    add_reference :partners, :organisation, foreign_key: true
  end
end
