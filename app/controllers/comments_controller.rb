class CommentsController < ApplicationController
  before_action :set_article

  def create
    unless current_user
      flash[:danger] = "Please Sign In to Comment"
      redirect_to new_user_session_path
    else
      @comment = @article.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        flash[:success] = "Comment has been added"
      else
        flash.now[:danger] = "Failed to add comment"
      end

      redirect_to article_path(@article)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_article
      @article = Article.find(params[:article_id])
    end
end
