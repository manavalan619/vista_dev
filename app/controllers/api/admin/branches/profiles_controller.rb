module Api
  module Admin
    module Branches
      class ProfilesController < Api::V1::BaseController
        def request
          authorize new_profile_request
          if Profile::Request.call(new_profile_request).success?
            render json: '', status: 200
          else
            render json: '', status: 422
          end
        end

        private

        def new_profile_request
          @new_profile_request ||= ProfileRequest.new(branch: branch, user: current_user)
        end

        def branch
          @branch ||= business_unit.branches.find(params[:branch_id])
        end

        def business_unit
          @business_unit ||= policy_scope(BusinessUnit).find(params[:unit_id])
        end
      end
    end
  end
end
