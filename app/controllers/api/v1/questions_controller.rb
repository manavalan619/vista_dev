module Api::V1
  class QuestionsController < Api::V1::BaseController
    before_action :find_question, only: [:show]

    has_scope :intro

    def index
      @questions = apply_scopes(Question).includes(:photo, answers: [:photo])
      render json: @questions if stale?(@questions)
    end

    def show
      authorize @question
      render json: @question if stale?(@question)
    end

    private

    def find_question
      @question = Question.find(params[:id])
    end
  end
end
