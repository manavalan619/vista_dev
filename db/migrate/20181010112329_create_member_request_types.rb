class CreateMemberRequestTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :member_request_types do |t|
      t.string :name
      t.references :business_unit
      t.timestamps
    end
  end
end
