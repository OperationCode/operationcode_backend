class User < ApplicationRecord
  after_create :welcome_user

  validates_format_of :email, :with => /@/

  def welcome_user
    invite_to_slack
    add_to_mailchimp
    add_to_airtables
  end

  def invite_to_slack
    SlackJobs::InviterJob.perform_later(email: email)
  end

  def add_to_mailchimp
    MailchimpInviterJob.perform_later(email: email)
  end

  def add_to_airtables
    AddUserToAirtablesJob.perform_later(self)
  end
end
