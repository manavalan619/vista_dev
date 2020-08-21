class Admin::VideosController < Admin::BaseController
  before_action :find_video, only: %i[edit update destroy]

  has_scope :in_organisation, as: :organisation do |controller, scope, value|
    # "vista" option in front-end should filter for videos with _no_ organisation associated
    # ie videos posted for all orgs, rather than one specific org
    value === 'vista' ? scope.for_vista : scope.in_organisation(value)
  end
  has_scope :search, as: :q

  def index
    @videos = apply_scopes(Video).newest_first.page(params[:pages])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @video = Video.new
  end

  def create
    @video = current_vista_admin.videos.new(video_params)

    if @video.save
      redirect_to [:admin, :videos],
                  success: 'Video was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @video.update video_params
      redirect_to %i[admin videos], success: 'Video updated'
    else
      render :edit
    end
  end

  def destroy
    @video.destroy
    redirect_to %i[admin videos], success: 'Video deleted'
  end

  private

  def video_params
    params.require(:video).permit(
      :name, :description, :organisation_id, :published,
      :url, content_category_ids: []
    )
  end

  def find_video
    @video = Video.find params[:id]
  end
end
