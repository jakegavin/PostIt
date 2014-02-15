class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    #@comment = Comment.new(com_params)
    #@comment.post = @post
    @comment = @post.comments.new(com_params)

    # Hardcoded since we don't have auth yet. 
    @comment.creator = User.last

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def com_params
    params.require(:comment).permit(:body)
  end
end