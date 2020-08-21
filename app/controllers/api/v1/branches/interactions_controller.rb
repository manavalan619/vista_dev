module Api
  module V1
    module Branches
      class InteractionsController < Api::V1::BaseController
        before_action :find_branch

        def index
          @interactions = current_user.interactions
                                      .where(branch: @branch)
                                      .page(params[:page])
                                      .per(params[:limit])
          render json: @interactions
        end

        private

        def find_branch
          @branch = Branch.find(params[:id])
        end
      end
    end
  end
end
