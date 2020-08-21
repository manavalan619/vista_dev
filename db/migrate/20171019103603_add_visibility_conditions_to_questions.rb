class AddVisibilityConditionsToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :visibility_conditions, :jsonb, default: [], null: false
  end
end
