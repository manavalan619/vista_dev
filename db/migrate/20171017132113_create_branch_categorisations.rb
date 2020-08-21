class CreateBranchCategorisations < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_categorisations do |t|
      t.belongs_to :branch, foreign_key: true, null: false
      t.belongs_to :partner_category, foreign_key: true, null: false

      t.timestamps
    end
  end
end
