class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.references :business_unit, foreign_key: true
      t.string :name


      t.timestamps
    end
  end
end
