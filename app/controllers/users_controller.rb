class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_no_user, only: [:new, :create]
  before_action only: [:edit, :update] do 
    require_owner(@user)
  end

  def new
    @user = User.new    
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Your account was created"
      session[:user_id] = @user.id
      redirect_to root_path      
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "The user was updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

end