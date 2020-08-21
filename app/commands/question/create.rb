class Question::Create
  prepend SimpleCommand

  def initialize(question)
    @question = question
  end

  def call
    return true if @question.save
    @question.errors.map { |key, value| errors.add(key, value) }
  end
end
