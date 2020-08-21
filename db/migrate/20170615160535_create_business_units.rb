class CreateBusinessUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :business_units do |t|
      t.string :name
      t.references :organisation, foreign_key: true

      t.timestamps
    end
  end
end
