class ChangeJsonbDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :categories, :visibility_conditions, from: [].to_json, to: []
    change_column_default :questions, :locking_conditions, from: [].to_json, to: []
  end
end
