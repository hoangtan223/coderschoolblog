class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.search(params[:search])

    if (params.has_key?(:tag))
      @tag = params[:tag]
      @articles = Tag.find_by_tag_name(@tag).articles
      flash[:notice] = "Articles which have #{@tag} tag"
    end

    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article.increase_view_count
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    if !@article.is_editable
      respond_to do |format|
      format.html { redirect_to @article, notice: 'Article is not editable.' }
        format.json { render :show, status: :unprocessable_entity, location: @article }
      end
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.generate_tags(params[:tags])
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.is_editable
        if @article.update(article_params)
          format.html { redirect_to @article, notice: 'Article was successfully updated.' }
          format.json { render :show, status: :ok, location: @article }
        else
          format.html { render :edit }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @article, notice: 'Article is not editable.' }
        format.json { render :show, status: :unprocessable_entity, location: @article }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if (!@article.is_deletable)
      respond_to do |format|
        format.html { redirect_to articles_url, notice: "Cannot delete author's article." }
        format.json { head :no_content }
      end     
    else
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
  end
