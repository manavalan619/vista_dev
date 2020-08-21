class CreatePartnerAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_assignments do |t|
      t.references :partner, foreign_key: true
      t.references :target, polymorphic: true

      t.timestamps
    end
  end
end
