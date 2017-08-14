class UserMailer < ApplicationMailer
  def sign_up_mail(user)
    @user = user
    mail(
      to: @user.email,
      subject: 'People App - New person added'
    )
  end
end
