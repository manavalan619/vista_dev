class Admin::QuestionsController < Admin::BaseController
  before_action :set_question, only: %i[show edit update destroy]

  has_scope :in_category, as: :category
  has_scope :of_kind, as: :kind
  has_scope :search, as: :q

  def index
    @questions = apply_scopes(Question).page(params[:page]).includes(:category)
    respond_to do |format|
      format.html
      format.json { render json: @questions.to_json(only: %i[id title]) }
      format.js
    end
  end

  def show
    redirect_to [:edit, :admin, @question]
  end

  def new
    @question = Question.new
    @question.photo || @question.build_photo
  end

  def edit
    @question.photo || @question.build_photo
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to admin_questions_path, success: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to admin_questions_path, success: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_questions_path, success: 'Question was successfully destroyed.'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(
      :category_id, :title, :kind, :locking_conditions, :intro, :allows_note,
      :note_title, :text_style, :blur_background, :background_overlay,
      locking_conditions: %i[question_id answer],
      photo_attributes: %i[id _destroy image remote_image_url image_cache],
      answers_attributes: [
        :id, :_destroy, :title, :description, :position, photo_attributes: [
          :id, :_destroy, :image, :remote_image_url, :image_cache
        ]
      ]
    )
  end
end
