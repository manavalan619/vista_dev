module Api
  module Partners
    module V1
      class BaseController < ApplicationController
        include ActionController::Serialization
        attr_reader :current_user
        helper_method :current_user
        attr_reader :token_context
        helper_method :token_context
        attr_reader :current_branch
        helper_method :current_branch
        attr_reader :current_branch_id
        helper_method :current_branch_id
        helper_method :current_organisation
        attr_reader :current_role
        helper_method :current_role

        protect_from_forgery with: :null_session

        before_action :convert_params_to_snakecase
        before_action :authenticate
        before_action :find_branch
        before_action :find_role
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

        def current_organisation
          current_user.try(:organisation)
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

        def authenticate_manager
          authenticate_token('manager') || render_401
        end

        def authenticate_staff
          authenticate_token('staff') || render_401
        end

        def authenticate
          authenticate_token || render_401
        end

        def authenticate_token(context = nil)
          authenticate_with_http_token do |token_from_headers, _|
            token_body = AuthenticationToken.decode(token_from_headers.try(:squish))
            token = AuthenticationToken.find_for_context(context, token_body)
            @token_context = token.try(:context)
            @current_user = token.try(:user)
          end
        end

        def find_branch
          branch_id = request.headers['X-BRANCH-ID']
          @current_branch = Branch.find_by id: branch_id
        end

        def current_branch_id
          request.headers['X-BRANCH-ID']
        end

        def find_role
          role_id = request.headers['X-ROLE-ID']
          return unless current_branch
          @current_role = current_branch.roles.find_by id: role_id
        end

        def set_raven_context
          Raven.user_context(
            id: current_user.try(:id),
            type: current_user.try(:class).try(:to_s) || 'StaffMember',
            ip_address: request.ip
          )
          Raven.extra_context(params: params.to_unsafe_h, url: request.url)
        end
      end
    end
  end
end
