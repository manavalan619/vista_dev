module Admin::Staff
  class AdminsController < Admin::BaseController
    before_action :find_organisation
    before_action :find_admin, only: %i[edit update destroy]

    def index
      @admins = @organisation.admins.page(params[:page])
    end

    def new
      @admin = @organisation.admins.new
    end

    def create
      @admin = @organisation.admins.new(admin_params)

      if @admin.save
        redirect_to [:admin, @organisation, :admins], success: 'Admin created'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @admin.update admin_params
        redirect_to [:admin, @organisation, :admins], success: 'Admin updated'
      else
        render :edit
      end
    end

    def destroy
      @admin.destroy
      redirect_to [:admin, @organisation, :admins], success: 'Admin deleted'
    end

    private

    def find_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end

    def find_admin
      @admin = @organisation.admins.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(permitted_params)
    end

    def permitted_params
      %i[employee_id first_name last_name email mobile_number pin pin_confirmation]
    end
  end
end
