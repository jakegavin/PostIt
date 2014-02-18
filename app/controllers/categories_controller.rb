class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_user, only: [:new, :create, :edit, :update]

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
    @category = Category.new(cat_params)

    if @category.save
      flash[:notice] = "The category was saved."
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(cat_params)
      flash[:notice] = "The category was updated."
      redirect_to categories_path
    else
      render :edit
    end
  end

  private

  def cat_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
