class  Admins::SessionsController < Admins::BaseAdminController


 before_action :require_login_a, except: [:new , :create ,:otp , :otp_admin]
layout 'login_admin'



def new
  # binding.pry
  @captcha = rand 1000..9999
    session[:captcha] = @captcha
  redirect_to dashboard_admins_admins_path(current_user_a) if logged_in_a? 

  end

def create
  # binding.pry
if session[:captcha] == params[:session][:captcha].to_i
   	@admin = Admin.find_by(email: params[:session][:email])  
    # binding.pry
    if @admin && @admin.authenticate(params[:session][:password])
       @admin= Admin.find_by(email: params[:session][:email])
         
       otp = rand 1000..9999
       @admin.update(onetimepassword: otp)
      
       AdminJob.perform_later(@admin)

       redirect_to otp_admins_sessions_path(id: @admin.id)

      
    else
      flash.now[:notice] = "Wrong Email and password"
      render 'admins/sessions/new'
    end
     else
      flash.now[:notice] = "Invalid captcha"
      @captcha = rand 1000..9999
      session[:captcha] = @captcha
           render 'admins/sessions/new'
     
end
  end



def otp
   @admin = Admin.find_by(id: params[:id])
end

def otp_admin

  @admin = Admin.find_by(id: params[:id])
	if @admin && @admin.onetimepassword == params[:session][:otp].to_i
	
	session[:admin_id] = @admin.id



	redirect_to dashboard_admins_admins_path(current_user_a)


  	else
  		flash.now[:notice] = "Wrong otp"
      render 'admins/sessions/otp'
  end
end

def destroy
   session[:admin_id] = nil
    flash[:notice] = "You have logged out"
    redirect_to new_admins_session_path
  end


  private
def require_login_a
    unless logged_in_a?
      flash[:notice] = "You must be logged in to access this section"
      redirect_to new_admins_session_path 
    end
  end
end