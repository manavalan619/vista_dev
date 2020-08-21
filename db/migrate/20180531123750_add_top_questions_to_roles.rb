class AddTopQuestionsToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :roles, :top_questions_data, :jsonb, default: []
  end
end
