class UserAnswer::Update
  prepend SimpleCommand

  def initialize(answer, params)
    @answer = answer
    @params = params
  end

  def call
    propagate_params
    return true if @answer.update(@params)
    @answer.errors.map { |key, value| errors.add(key, value) }
  end

  private

  def propagate_params
    case @params[:values]
    when String
      @params[:values] = YAML.load(@params[:values])
    end
  end
end
