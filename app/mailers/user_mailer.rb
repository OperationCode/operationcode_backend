class UserMailer < ActionMailer::Base
  default from: 'staff@operationcode.org'

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Operation Code!"
  end
end
