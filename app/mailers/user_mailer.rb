class UserMailer < ActionMailer::Base
  default from: 'eilish@operationcode.org'

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome to Operation Code!"
  end
end
