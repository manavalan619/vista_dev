class AddProfileFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :job_title, :string
    add_column :users, :company, :string
    add_column :users, :address, :string
  end
end
