class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
       # @articles = Article.paginate(page: params[:page], per_page: 5)
        @pagy, @articles = pagy(Article.all, items: 5)
    end

    def show
    end

    def new
        @article = Article.new
    end

    def create 
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            flash[:notice] = "Article was created succesfully"
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit 
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was updated succesfully"
            redirect_to @article
        else
            render :edit, status: :unprocessable_entity 
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private 

    def set_article 
        @article = Article.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def article_params
        params.require(:article).permit(:title, :description)
    end
end