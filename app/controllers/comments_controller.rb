class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, except: [:create]

  def create
    @comment = @article.comments.build(comment_params)
    
    if @comment.save
      redirect_to article_path(@article), notice: 'Comment was successfully added.'
    else
      flash.now[:alert] = 'Failed to add comment.'
      render 'articles/show', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @article, notice: 'Comment was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update comment.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article), status: :see_other, notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end