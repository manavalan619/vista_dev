module Api
  module Partners
    module V1
      class RolesController < Api::Partners::V1::BaseController
        def index
          @roles = policy_scope(Role)
          render json: @roles
        end
      end
    end
  end
end
