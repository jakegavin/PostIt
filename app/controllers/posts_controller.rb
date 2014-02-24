class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]
  
  # @user is needed for require_same_user
  before_action :set_post_creator, only: [:edit, :update]

  before_action :require_same_user, only: [:edit, :update]

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
      flash[:notice] = "Vote counted"
    else
      flash[:danger] = "You can only vote for that once"
    end

    redirect_to :back

  end
  
  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end  

  def set_post
    @post = Post.find(params[:id])
  end

  def set_post_creator
    @user = @post.creator
  end

end
