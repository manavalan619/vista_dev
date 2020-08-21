class Admin::OrganisationsController < Admin::BaseController
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

  def index
    @organisations = Organisation.page(params[:page])
  end

  def show
  end

  def new
    @organisation = Organisation.new
    @organisation.build_photo
  end

  def edit
    @organisation.photo || @organisation.build_photo
  end

  def create
    @organisation = Organisation.new(organisation_params)

    if @organisation.save
      redirect_to admin_organisations_path, success: 'Organisation was successfully created.'
    else
      render :new
    end
  end

  def update
    if @organisation.update(organisation_params)
      redirect_to admin_organisations_path, success: 'Organisation was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @organisation.destroy
    redirect_to admin_organisations_path, success: 'Organisation was successfully destroyed.'
  end

  private

  def set_organisation
    @organisation = Organisation.find(params[:id])
  end

  def organisation_params
    params.require(:organisation).permit(
      :name, :about,
      photo_attributes: %i[image remote_image_url],
      address_attributes: %i[
        label line1 line2 town county postcode country phone latitude longitude
      ]
    )
  end
end
