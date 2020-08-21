class Admin::PreferenceGroupsController < Admin::BaseController
  before_action :find_preference_group, only: %i[show edit update destroy]

  def index
    @preference_groups = PreferenceGroup.page(params[:page])
  end

  def show
    redirect_to [:edit, :admin, @preference_group]
  end

  def new
    @preference_group = PreferenceGroup.new
  end

  def create
    @preference_group = PreferenceGroup.new preference_group_params

    if @preference_group.save
      redirect_to %i[admin preference_groups], success: 'Preference group created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @preference_group.update preference_group_params
      redirect_to %i[admin preference_groups], success: 'Preference group updated'
    else
      render :edit
    end
  end

  def destroy
    @preference_group.destroy
    redirect_to %i[admin preference_groups], success: 'Preference group deleted'
  end

  private

  def find_preference_group
    @preference_group = PreferenceGroup.find(params[:id])
  end

  def preference_group_params
    params.require(:preference_group).permit(:title, question_ids: [])
  end
end
