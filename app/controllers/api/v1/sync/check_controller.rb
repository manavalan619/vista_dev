module Api::V1::Sync
  class CheckController < Api::V1::BaseController
    def index
      render json: {
        categories: Category.maximum(:updated_at),
        questions: Question.maximum(:updated_at),
        me: current_user.updated_at
      }
    end
  end
end
