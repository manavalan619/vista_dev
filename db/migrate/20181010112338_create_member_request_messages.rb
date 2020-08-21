class CreateMemberRequestMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :member_request_messages do |t|
      t.text :body
      t.string :status
      t.references :member_request
      t.integer :messageable_id
      t.string :messageable_type
      t.timestamps
    end

    add_index :member_request_messages, [:messageable_type, :messageable_id], name: 'request_message_index'
  end
end
