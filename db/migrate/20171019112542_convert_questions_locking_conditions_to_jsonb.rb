class ConvertQuestionsLockingConditionsToJsonb < ActiveRecord::Migration[5.1]
  def change
    change_column :questions, :locking_conditions, :jsonb, default: [], null: false
  end
end
