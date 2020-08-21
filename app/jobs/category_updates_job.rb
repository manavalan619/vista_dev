class CategoryUpdatesJob < ApplicationJob
  queue_as :default

  def perform
    results.each do |category_id, question_ids|
      CategoryUpdate.create(category_id: category_id, question_ids: question_ids)
    end
  end

  private

  def results
    @results ||= begin
      questions.each_with_object({}) do |hash, memo|
        question_id = hash[:id]
        category_id = hash[:category_id]

        memo[category_id] ||= []
        memo[category_id].push(question_id)
        memo
      end
    end
  end

  def questions
    @questions ||= Question.unprocessed.pluck_to_hash(:id, :category_id)
  end
end
