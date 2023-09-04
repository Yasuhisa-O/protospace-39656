class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to prototype_comments_path(comment.prototype.id)
      # redirect_to "/prototypes/#{comment.prototype.id}"
    else
      @prototype = comment.prototype
      @comment = comment
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show" # views/tweets/show.html.erbのファイルを参照しています。
    end
  end
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
