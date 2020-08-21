class DeviseCreatePartnerUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_users do |t|
      t.string   :email,              null: false, default: ""
      t.string   :first_name
      t.string   :last_name
      t.string   :mobile_number
      t.string   :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip
      t.string   :authentication_token
      t.timestamps null: false
      t.references :organisation
      t.references :branch
      t.string   :type
    end

    add_index :partner_users, :email,                unique: true
    add_index :partner_users, :reset_password_token, unique: true
    add_index :partner_users, :authentication_token, unique: true
  end
end
