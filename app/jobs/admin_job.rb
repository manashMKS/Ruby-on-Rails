class AdminJob < ApplicationJob
  queue_as :default

  def perform (admin)
    UserMailer.otp_email_admin(admin).deliver
  end
end
