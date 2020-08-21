namespace :counter_cache do
  desc 'Counter cache for category has many questions'
  task category_questions: :environment do
    Category.reset_column_information
    Category.find_each do |category|
      category_ids = category.subtree_ids

      category.update(
        questions_count: Question.where(category: category.id).count,
        subtree_questions_count: Question.where(category_id: category_ids).count
      )
    end
  end
end
