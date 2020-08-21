class Admin::ReleasesController < Admin::BaseController
  def index
    @releases = Release.page(params[:page])
  end

  def create
    @release = Release.create
    respond_to do |format|
      format.html { redirect_to %i[admin releases], success: 'Release queued' }
      format.js
    end
  end

  def destroy
    @release = Release.find params[:id]
    @release.destroy
    redirect_to %i[admin releases], success: 'Release deleted'
  end

  def download
    @release = Release.find params[:id]

    filename = "release-#{@release.created_at.to_i}.json"

    redirect_to @release.file.url

    # send_file @release.file.url,
    #           filename: filename,
    #           type: Mime[:json],
    #           disposition: 'attachment',
    #           url_based_filename: true
  end
end
