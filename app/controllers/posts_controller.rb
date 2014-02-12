class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :set_ncom, only: [:create, :edit]

  def index
    @posts = Post.all
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

    @post.creator = User.last

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
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end  

  def set_post
    @post = Post.find(params[:id])
  end

  def set_ncom

  end
end
