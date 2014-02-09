class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]

  def index
    @categories = Category.all.sort_by!{ |e| e.name.downcase }
  end

  def show
    @posts = Category.find(params[:id]).posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(post_params)

    if @category.save
      flash[:notice] = "Your category was saved."
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(post_params)
      flash[:notice] = "Your category was updated."
      redirect_to categories_path
    else
      render :edit
    end
  end

  def post_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
