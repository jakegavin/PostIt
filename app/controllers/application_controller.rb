class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_no_user
    if logged_in?
      flash[:danger] = "You can't do that when you're logged in."
      redirect_to root_path
    end
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You do not have permission do do that."
      # TODO: redirect back if the HTTP referer is on this site. We don't want to redirect back if the referer is a different site. 
      #if session['referer'].nil? 
        redirect_to :root 
      #else
      #  redirect_to :back
      #end
    end   
  end
end

