class AddQuestionsCountToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :questions_count, :integer, default: 0
  end
end
