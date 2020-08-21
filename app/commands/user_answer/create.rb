class UserAnswer::Create
  prepend SimpleCommand

  def initialize(answer)
    @answer = answer
  end

  def call
    propagate_params
    return true if @answer.save
    @answer.errors.map { |key, value| errors.add(key, value) }
  end

  private

  def propagate_params
    case @answer.values
    when String
      @answer.values = YAML.load(@answer.values)
    end
  end
end
