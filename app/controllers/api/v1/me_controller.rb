module Api
  module V1
    class MeController < Api::V1::BaseController
      # before_action :transform_params_if_multipart!

      def show
        render json: current_user if stale?(current_user)
      end

      def update
        if User::Update.call(current_user, user_params).success?
          render json: current_user, status: 200
        else
          render json: current_user, status: 422
        end
      end

      private

      def user_params
        params.require(:user).permit(permitted_attributes)
      end

      def permitted_attributes
        [
          :name, :first_nam, :last_name, :job_title, :company, :address, :avatar,
          :onboarding_complete, :gender, preferences: {}
        ]
      end

      def transform_params_if_multipart!
        content_type = request.headers['content-type']
        return unless %r{^multipart\/form-data*}.match?(content_type)
        underscore_hash = lambda { |hash|
          hash.transform_keys!(&:underscore)
          hash.each_value do |value|
            if value.is_a?(ActionController::Parameters)
              underscore_hash.call(value)
            elsif value.is_a?(Array)
              value.each do |item|
                next unless item.is_a?(ActionController::Parameters)
                underscore_hash.call(item)
              end
            end
          end
        }
        underscore_hash.call(params)
      end
    end
  end
end
