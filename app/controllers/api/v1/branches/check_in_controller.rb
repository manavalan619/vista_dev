module Api
  module V1
    module Branches
      class CheckInController < Api::V1::BaseController
        def create
          command = CheckIn::Create.call(current_user, branch, check_in_params)

          if command.success?
            render json: command.result, status: :created
          else
            render json: command.result, status: :unprocessable_entity
          end
        end

        private

        def check_in_params
          params.require(:check_in).permit(permitted_attributes)
        end

        def permitted_attributes
          %i[arrival_date arrival_time_start arrival_time_end]
        end

        def branch
          @branch ||= Branch.find(params[:id])
        end
      end
    end
  end
end
