module Api::V1
  class UserAnswersController < Api::V1::BaseController
    before_action :find_answer, except: %i[index create]

    def index
      @answers = current_user.answers
      render json: @answers if stale?(@answers)
    end

    def show
      render json: @answer if stale?(@answer)
    end

    def create
      @answer = current_user.answers.build(answer_params)

      if UserAnswer::Create.call(@answer).success?
        render json: @answer, status: 201
      else
        render json: @answer, status: 422
      end
    end

    def update
      if UserAnswer::Update.call(@answer, answer_params).success?
        render json: @answer, status: 200
      else
        render json: @answer, status: 422
      end
    end

    def destroy
      if UserAnswer::Destroy.call(@answer).success?
        head 204
      else
        head 422
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:question_id, :note, :values)
    end

    def find_answer
      @answer = current_user.answers.find_by(question_id: params[:id])
    end
  end
end
