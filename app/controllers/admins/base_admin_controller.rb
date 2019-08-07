class Admins::BaseAdminController < ActionController::Base
layout 'fixed'
	protect_from_forgery
  	include AdminsHelper
	include SessionsHelper


	def log_in_a(admin)
    session[:admin_id] = @admin.id
  end


  def current_user_a
    if session[:admin_id]
      @current_user_a ||= Admin.find_by(id: session[:admin_id])
    end
  end


  def logged_in_a?
    !current_user_a.nil?
  end

   def log_out_a
    session.delete(:admin_id )
    @current_user_a = nil
  end	
  
	  end