class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :current_user_is_owner?, :voted_for?

  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def current_user_is_owner?(owner)
    if logged_in? and (current_user.admin? or current_user == owner)
      true
    else
      false
    end
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def require_no_user
    if logged_in?
      flash[:danger] = "You can't do that while logged in."
      redirect_to root_path
    end
  end

  def require_owner(owner)
    access_denied unless current_user_is_owner?(owner) 
  end

  def voted_for?(type, id, vote)
    if logged_in?
      @votes ||= current_user.votes
      !@votes.where(voteable_type: type, voteable_id: id, vote: vote).empty?
    else
      false
    end
  end

  def access_denied
    flash[:danger] = "You do not have permission do do that."
    redirect_to :root      
  end 
end