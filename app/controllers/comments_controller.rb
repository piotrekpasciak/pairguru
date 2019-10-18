class CommentsController < ApplicationController
  before_action :load_comment, only: :destroy
  before_action :authorize_user, only: :destroy

  def create
    comment = Comment.new(comment_params)

    if comment.save
      flash[:notice] = "Comment created successfully"
    else
      flash[:error] = comment.errors.full_messages.to_sentence
    end

    redirect_to movie_path(params[:movie_id])
  end

  def destroy
    @comment.destroy!

    flash[:notice] = "Comment destroyed successfully"

    redirect_to movie_path(params[:movie_id])
  end

  private

  def comment_params
    params.require(:comment)
      .permit(:message)
      .merge(movie_id: params[:movie_id], user_id: current_user.id)
  end

  def authorize_user
    return head :unauthorized unless @comment.user == current_user
  end

  def load_comment
    @comment = Comment.find_by!(id: params[:id])
  end
end
