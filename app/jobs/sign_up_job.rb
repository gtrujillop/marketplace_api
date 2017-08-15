class SignUpJob < ApplicationJob
  def perform(user)
    UserMailer.sign_up_mail(user).deliver_now
  end
end
