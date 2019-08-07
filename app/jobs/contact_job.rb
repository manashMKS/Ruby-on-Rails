class ContactJob < ApplicationJob
  queue_as :default

   def perform(user)
    UserMailer.otp_email(user).deliver
  end

end
