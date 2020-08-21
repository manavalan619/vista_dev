class ChangeCategoryVisibilityConditionsDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :categories, :visibility_conditions, from: nil, to: [].to_json
  end
end
