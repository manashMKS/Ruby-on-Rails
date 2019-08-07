
class Users::PasswordResetsController < ApplicationController

	before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
 before_action :check_expiration, only: [:edit, :update]

  def new

  end



def create

    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
    	UserMailer.with(user: @user).password_reset.deliver_now 
      flash[:notice] = "Email sent with password reset instructions"
      redirect_to new_users_session_path
    else
      flash.now[:notice] = "Email address not found"
      render new_users_password_reset_path
      # redirect_to login_path  
  end
end



  def edit
  end

 def update

 	@user = User.find_by(email: params[:email])
     @user.update!(password: params[:User][:password] , password_confirmation: params[:User][:password_confirmation] )    
    	
       # @user.update_attributes(reset_digest: nil)
      flash[:notice] = "Password has been reset."
      redirect_to new_users_session_path
   
end





  private

  def user_params
     params.permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to new_users_session_path
      end
    end


def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_users_password_reset_url
      end
    end

end
