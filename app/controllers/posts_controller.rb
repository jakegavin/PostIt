class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]

  before_action only: [:edit, :update] do
    @user = @post.creator
    require_owner(@user)
  end

  def index
    @posts = Post.all.sort_by {|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    

    if @post.save
      flash[:notice] = "The post was created."
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    
    if @vote.valid?
      respond_to do |format|
        format.html {redirect_to :back, notice: "Vote counted"}
        format.js
      end
    else
      flash[:danger] = "You can only vote for that once"
    end

  end
  
  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end  

  def set_post
    @post = Post.find(params[:id])
  end
end
