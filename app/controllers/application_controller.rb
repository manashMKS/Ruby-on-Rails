class ApplicationController < ActionController::Base
  layout false
  protect_from_forgery with: :null_session 
  	include SessionsHelper
    include AdminsHelper
   include UsersRoleHelper
  	



  def current_user_a
    if session[:admin_id]
      @current_user_a ||= Admin.find_by(id: session[:admin_id])
    end
  end

def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?

  	!!current_user
  end

  
 def log_out
    session.delete(:user_id )
    @current_user = nil
  end


end
