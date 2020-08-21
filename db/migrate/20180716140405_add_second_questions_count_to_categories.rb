class AddSecondQuestionsCountToCategories < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :questions_count, :subtree_questions_count
    add_column :categories, :questions_count, :integer, default: 0

    Category.update_all("questions_count=(SELECT COUNT(*) FROM questions WHERE questions.category_id=categories.id)")
  end
end
