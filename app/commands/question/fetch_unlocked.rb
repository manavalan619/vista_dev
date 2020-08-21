class Question::FetchUnlocked
  def initialize(scope)
    @scope = scope
  end

  def call
    Question.where(id: question_ids)
  end

  private

  def unanswered_questions
    Question.where.not(id: @scope.pluck(:question_id))
  end

  def question_ids
    unanswered_questions.reject(&method(:locked?)).map(&:id)
  end

  def locked?(question)
    answers = Hash[Answer.where(question_id: question.locking_conditions.keys).pluck(:question_id, :values)]
    question.locking_conditions.any? do |question_id, locking_values|
      if values = answers[question_id.to_i]
        (values & locking_values).present?
      else
        true
      end
    end
  end
end
