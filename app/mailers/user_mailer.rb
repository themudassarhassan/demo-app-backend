class UserMailer < ApplicationMailer
  def password_reset_token_email
    @data = params[:data]
    mail(to: @data[:email], subject: 'Password Reset Token')
 end
end
