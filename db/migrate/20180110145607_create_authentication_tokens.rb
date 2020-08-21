class CreateAuthenticationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :authentication_tokens do |t|
      t.string :context
      t.string :body
      t.references :user, polymorphic: true
      t.datetime :last_used_at
      t.inet :ip_address
      t.string :user_agent

      t.timestamps
    end
    add_index :authentication_tokens, :context
  end
end
