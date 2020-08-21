class Question::Destroy
  prepend SimpleCommand

  def initialize(question)
    @question = question
  end

  def call
    return true if @question.destroy
    errors.add(:removing_answer, 'cannot remove question')
  end
end
