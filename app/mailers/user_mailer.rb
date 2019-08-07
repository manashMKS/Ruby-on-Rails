class UserMailer < ApplicationMailer
	default from: '1997manash.swain@gmail.com'
 
  def welcome_email user
    # binding.pry
    @user = user
     # @url  = '/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end


  def otp_email user
    @user = user
    
  	# @user = params[:user]
  	mail(to: @user.email,subject: 'Your one time password is')
  end


  def otp_email_admin admin
    @admin = admin
  	# @user = params[:user]
  	mail(to: @admin.email,subject: 'Your one time password is')
  end




  #  def account_activation
  #   @user = params[:user]
  #   mail to: @user.email, subject: "Account activation"
  # end

  def password_reset
     user = params[:user]
    mail(to: user.email, subject: "Password reset")
  end


end
