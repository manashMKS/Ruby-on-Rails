class Users::SessionsController < ApplicationController

  
before_action :require_login, except: [:new ,:create ,:otp,:otp_user , :create_admin]
layout 'login_admin'
before_action :status_check, except: [:new , :create,:otp ,:otp_user]


  def new
    # binding.pry
      @captcha = rand 1000..9999
      session[:captcha] = @captcha
      redirect_to users_user_path(id: current_user.id) if logged_in? 

  end


def show

end
  


   def create
   # binding.pry 
     if session[:captcha] == params[:session][:captcha].to_i
      @user = User.find_by(email: params[:session][:email]) 

       if @user && @user.authenticate(params[:session][:password]) && @user.status==false
   
       @user= User.find_by(email: params[:session][:email])

       otp = rand 1000..9999
       @user.update(onetimepassword: otp)
       
       ContactJob.perform_later(@user) 
       render 'users/sessions/otp'


       
              elsif @user && @user.authenticate(params[:session][:password]) && @user.status==true
          flash.now[:notice] = "you are blocked by Admin"
           render 'users/sessions/new'
          
          else
          flash.now[:notice] = "Wrong email and password"
        render 'users/sessions/new'
             end
        
    else
      flash.now[:notice] = "Invalid captcha"
      @captcha = rand 1000..9999
      session[:captcha] = @captcha
           render 'users/sessions/new'
     
end

end




def create_admin
   @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
      session[:user_id] = @user.id
      WelcomeJob.perform_later
      redirect_to dashboard_users_users_path(id: @user.id)
end


def otp
 @user = User.find_by(id: params[:id])  
end


  def otp_user
      # binding.pry 
      @user = User.find_by(id: params[:id])
  if @user && @user.onetimepassword == params[:session][:otp].to_i && @user.status==false
	
	session[:user_id] = @user.id
	redirect_to dashboard_users_users_path(id: @user.id)
  		 	
  	else
  		flash.now[:notice] = "Wrong otp"
      redirect_to otp_users_sessions_path(id: @user.id)
  end
  

end



  def destroy

    session.delete(:user_id )
     session[:user_id] = nil

    flash[:notice] = "You have logged out"  
    redirect_to new_users_session_path
  end


private
def require_login 
 
    unless logged_in? 
      flash[:notice] = "You must be logged in to access this section"
      redirect_to new_users_session_path
    end
  
  end

def status_check
   if current_user.status == true
    flash[:notice] = "You are blocked by admin"
    redirect_to new_users_session_path
end
end


end




