module Api::Admin
  class QuestionsController < Api::Admin::ApiController
    before_action :find_question, except: %i[index create]

    def index
      @questions = policy_scope(Question)
      render json: @questions if stale?(@questions)
    end

    def show
      authorize @question
      render json: @question if stale?(@question)
    end

    def create
      @question = Question.new(question_params)
      authorize @question
      if Question::Create.call(@question).success?
        render json: @question, status: 201
      else
        render json: @question, status: 422
      end
    end

    def update
      authorize @question
      if Question::Update.call(@question, question_params).success?
        render json: @question, status: 200
      else
        render json: @question, status: 422
      end
    end

    def destroy
      authorize @question
      if Question::Destroy.call(@question).success?
        head 204
      else
        head 422
      end
    end

    private

    def question_params
      params.require(:question).permit(:name, :category_id, :kind, possible_answers: {}, lock_by: {}, unlock_by: {})
    end

    def find_question
      @question = Question.find(params[:id])
    end
  end
end
