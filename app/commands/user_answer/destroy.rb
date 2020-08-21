class UserAnswer::Destroy
  prepend SimpleCommand

  def initialize(answer)
    @answer = answer
  end

  def call
    return true if @answer.destroy
    errors.add(:removing_answer, 'cannot remove answer')
  end
end
