class Admin::ArticlesController < Admin::BaseController
  before_action :find_article, only: %i[show edit update destroy]

  has_scope :search, as: :q

  def index
    @articles = apply_scopes(Article).newest_first.page(params[:page])
  end

  def new
    @article = Article.start_draft
    @article.build_header_image
  end

  def show
    redirect_to [:edit, :admin, @article]
  end

  def edit
    @article.header_image || @article.build_header_image
  end

  def update
    if @article.update article_params
      redirect_to %i[admin articles], success: 'Article updated'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to %i[admin articles], success: 'Article deleted'
  end

  private

  def find_article
    @article = Article.find params[:id]
  end

  def article_params
    params.require(:article).permit(
      :title, :content, :publish_at,
      header_image_attributes: %i[id _destroy image remote_image_url image_cache],
      content_category_ids: []
    )
  end
end
