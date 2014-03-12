class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]

  before_action only: [:edit, :update] do
    @creator = @post.creator
    require_owner(@creator)
  end

  def index
    @posts = Post.all.sort_by {|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json {render json: @post}
      format.xml {render xml: @post }
    end
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
    
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Vote counted"
        else
          flash[:danger] = "You can onlt vote once."
        end
        redirect_to :back
      end
      format.js
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end  

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end
