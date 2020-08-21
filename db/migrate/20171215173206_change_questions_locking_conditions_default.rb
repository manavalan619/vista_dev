class ChangeQuestionsLockingConditionsDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :questions, :locking_conditions, from: nil, to: [].to_json
  end
end
