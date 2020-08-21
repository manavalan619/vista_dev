class CreateMemberRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :member_requests do |t|
      t.references :user
      t.references :business_unit
      t.references :member_request_type
      t.string :status
      t.timestamps
    end
  end
end
