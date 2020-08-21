module Api::V1
  class BaseController < ApplicationController
    include ActionController::Serialization
    attr_reader :current_user
    helper_method :current_user

    protect_from_forgery with: :null_session

    before_action :convert_params_to_snakecase
    before_action :authenticate
    before_action :set_raven_context
    before_action :set_paper_trail_whodunnit
    # after_action :verify_authorized, except: :index
    # after_action :verify_policy_scoped, only: :index
    serialization_scope :view_context
    respond_to :json

    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ::AbstractController::ActionNotFound, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400
    rescue_from ActiveModel::ForbiddenAttributesError, with: :render_400
    rescue_from Pundit::NotAuthorizedError, with: :render_403

    def pundit_user
      current_user
    end

    def user_for_paper_trail
      current_user.try(:id) || 'Missing'
    end

    protected

    def render_404
      render json: 'Resource not found', status: 404
    end

    def render_403
      render json: 'Forbidden', status: 403
    end

    def render_401
      render json: 'Invalid credentials', status: 401
    end

    def render_400
      render json: 'Bad request', status: 400
    end

    def authenticate
      authenticate_token || render_401
    end

    def authenticate_token
      authenticate_with_http_token do |token, _|
        @current_user = User.find_by(authentication_token: token)
      end
    end

    def set_raven_context
      Raven.user_context(
        id: current_user.try(:id),
        type: 'User',
        ip_address: request.ip
      )
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
  end
end
