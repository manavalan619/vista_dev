module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      def share
        authorize new_share
        if Profile::Share.call(new_share).success?
          render json: '', status: 200
        else
          render json: '', status: 422
        end
      end

      def revoke
        authorize share
        if Profile::Revoke.call(share).success?
          render json: '', status: 200
        else
          render json: '', status: 422
        end
      end

      def revoke_all
        authorize member
        if Profile::RevokeAll.call(member).success?
          render json: '', status: 200
        else
          render json: '', status: 422
        end
      end

      private

      def new_share
        @new_share ||= Share.new(branch: branch, user: current_user)
      end

      def share
        @share ||= Share.find(params[:share_id])
      end

      def branch
        @branch ||= Branch.find(params[:branch_id])
      end
    end
  end
end
