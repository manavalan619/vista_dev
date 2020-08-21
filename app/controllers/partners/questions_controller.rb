class Partners::QuestionsController < Partners::BaseController
  def index
    @questions = policy_scope(Question).page(params[:page])
    # authorize @questions
    render json: @questions.to_json(only: %i[id title])
  end
end
