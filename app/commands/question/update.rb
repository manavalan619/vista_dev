class Question::Update
  prepend SimpleCommand

  def initialize(question, params)
    @question = question
    @params = params
  end

  def call
    return true if @question.update(@params)
    @question.errors.map { |key, value| errors.add(key, value) }
  end
end
