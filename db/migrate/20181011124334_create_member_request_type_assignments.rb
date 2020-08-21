class CreateMemberRequestTypeAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :member_request_type_assignments do |t|
      t.references :role
      t.references :member_request_type
      t.timestamps
    end
  end
end
