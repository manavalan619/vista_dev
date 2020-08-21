module Api::V1
  class SyncController < Api::V1::BaseController
    def index
      render json: {
        answers: current_user.answers.pluck(:question_id, :updated_at).map do |answer|
          {
            questionId: answer[0],
            updatedAt: answer[1]
          }
        end
      }
    end

    def create
      @user_answers = current_user.answers

      UserAnswer.transaction do
        add_answers
        update_answers
        delete_answers
      end

      render json: @user_answers.where(question_id: sync_params[:get])
    end

    private

    def add_answers
      return unless sync_params[:add]
      @user_answers.create(sync_params[:add])
      # sync_params[:add].each do |answer_params|
      #   answer = @user_answers.create(answer_params)
      # end
    end

    def update_answers
      return unless sync_params[:update]
      sync_params[:update].each do |answer_params|
        @user_answers.find_by(question_id: answer_params[:question_id]).update(answer_params)
      end
    end

    def delete_answers
      return unless sync_params[:delete]
      @user_answers.where(question_id: sync_params[:delete]).destroy_all
    end

    def sync_params
      params.permit(
        delete: [],
        get: [],
        add: [:question_id, :values, :note, values: []],
        update: [:question_id, :values, :note, values: []]
      )
    end
  end
end
