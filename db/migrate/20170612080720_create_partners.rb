class CreatePartners < ActiveRecord::Migration[5.1]
  def change
    create_table :partners do |t|
      t.string :first_name
      t.string :last_name
      t.integer :mobile_number

      t.timestamps
    end

    add_index :partners, [:first_name, :last_name], unique: true
  end
end
