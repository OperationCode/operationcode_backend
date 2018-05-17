class UserMailer < ActionMailer::Base
  default from: 'staff@operationcode.org'

  def welcome(user)
    @user = user
    mail to: @user.email, subject: 'Welcome to Operation Code!'
  end

  def new_user_in_leader_area(leader, new_user)
    @new_user = new_user
    mail to: leader.email, subject: 'A new user has joined within 50 miles of you'
  end
end
