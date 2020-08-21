module Api::V1
  class MoodController < Api::V1::BaseController
    def create
      @mood = current_user.moods.new mood_params

      if @mood.save
        render json: @mood
      else
        render json: @mood, status: 422
      end
    end

    private

    def mood_params
      params.require(:mood).permit(:value)
    end
  end
end
