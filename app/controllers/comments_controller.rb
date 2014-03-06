class CommentsController < ApplicationController

  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(com_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(creator: current_user, vote: params[:vote], voteable: @comment)

    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was saved."
        else
          flash[:danger] = "You can only vote on that once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private

  def com_params
    params.require(:comment).permit(:body)
  end

end