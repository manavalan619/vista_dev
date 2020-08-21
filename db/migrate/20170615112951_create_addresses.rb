class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :label
      t.string :line1
      t.string :line2
      t.string :town
      t.string :county
      t.string :postcode
      t.string :country
      t.string :phone
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end
