class RemoveUserSubject < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :subject_id
    remove_column :users, :subject_type
  end
end
