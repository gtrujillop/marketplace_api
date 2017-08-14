class SignUpJob < ApplicationJob
  def perform(user)
    UserMailer.sign_up_mail(user)
  end
end
