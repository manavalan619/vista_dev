class CreatePartnerCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_categories do |t|
      t.string :title
      t.integer :position, default: 0, null: false

      t.timestamps
    end
    add_index :partner_categories, :position
  end
end
