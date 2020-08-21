module Api
  module V1
    module Branches
      class ShareController < Api::V1::BaseController
        def create
          command = Share::Authorise.call(
            branch: branch,
            user: current_user,
            via: 'user'
          )
          if command.success?
            head 204
          else
            head 422
          end
        end

        def destroy
          if Share::Revoke.call(branch: branch, user: current_user).success?
            head 204
          else
            head 422
          end
        rescue
          head 422
        end

        def revoke_all
          if Share::RevokeAll.call(current_user).success?
            head 204
          else
            head 422
          end
        end

        private

        def branch
          @branch ||= Branch.find(params[:id])
        end
      end
    end
  end
end
