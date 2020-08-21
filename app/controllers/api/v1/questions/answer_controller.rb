module Api
  module V1
    module Questions
      class AnswerController < Api::V1::BaseController
        # before_action :find_question, only: :create

        def create
          @answer = current_user.answers.find_or_initialize_by(
            question_id: params[:id]
          )
          if @answer.update user_answer_params
            render json: @answer, status: 201
          else
            render json: @answer, status: 422
          end
        end

        def destroy
          @answer = current_user.answers.find_by question_id: params[:id]
          if @answer.destroy
            head 204
          else
            head 422
          end
        end

        private

        def find_question
          @question = Question.find params[:id]
        end

        def user_answer_params
          params.require(:answer).permit(:values, :note, values: [])
        end
      end
    end
  end
end
