class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)

    if comment.save
      flash[:notice] = "Comment created successfully"
    else
      flash[:error] = comment.errors.full_messages.to_sentence
    end

    redirect_to movie_path(params[:movie_id])
  end

  private

  def comment_params
    params.require(:comment)
      .permit(:message)
      .merge(movie_id: params[:movie_id], user_id: current_user.id)
  end
end
