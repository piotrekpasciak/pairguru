class TopCommentersController < ApplicationController
  def index
    @top_commenters = User.joins(:last_week_comments)
      .group("users.id")
      .select("users.name, users.email, COUNT(comments.id) AS last_week_comments_count")
      .order("last_week_comments_count desc")
      .limit(10)
  end
end
