class CreateAnswerVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :answer_versions do |t|
      t.references :item,  polymorphic: true, null: false
      t.string     :event, null: false
      t.string     :whodunnit
      t.jsonb      :object
      t.jsonb      :object_changes
      t.inet       :ip_address
      t.string     :user_agent

      t.datetime :created_at
    end
  end
end
