module Api::Admin
  class RolesController < Api::Admin::ApiController
    before_action :set_role, only: %i[show update destroy]
    before_action :find_new_role, only: :destroy

    def index
      @roles = policy_scope(Role)
      authorize @roles
      render json: @roles if stale?(@roles)
    end

    def show
      authorize @role
      render json: @role if stale?(@role)
    end

    def create
      @role = current_organisation.roles.new(role_params)
      authorize @role
      if Role::Create.call(@role).success?
        render json: @role, status: 201
      else
        render json: @role, status: 422
      end
    end

    def update
      authorize @role
      if Role::Update.call(@role, role_params).success?
        render json: @role, status: 200
      else
        render json: @role, status: 422
      end
    end

    def destroy
      authorize @role

      assign_new_role

      if Role::Destroy.call(@role).success?
        head :no_content
      else
        head 422
      end
    end

    private

    def set_role
      @role = policy_scope(Role).find(params[:id])
    end

    def find_new_role
      @new_role = policy_scope(Role).find_by id: params[:replace_with]
      return if @new_role.present?

      render json: { errors: [{ title: 'Please specify replacement role' }] },
             status: 422 and return
    end

    def assign_new_role
      StaffMember.joins(:roles).where(roles: { id: @role }).find_each do |sm|
        sm.roles << @new_role
      end
    end

    def role_params
      params.require(:role).permit(:name)
    end
  end
end
