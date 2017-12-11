class AddUserToAirtablesJob < ActiveJob::Base
  queue_as :default

  Airrecord.api_key = OperationCode.fetch_secret_with(name: :airtable_api_key)

  def perform(user)
    @user = user

    member_entry = AirTableMember.new(
      id: @user.id,
      first_name: @user.first_name,
      last_name: @user.last_name,
      slack_name: @user.slack_name,
      education: @user.education,
      employment_status: @user.employment_status,
      email: @user.email,
      zip: @user.zip,
    )

    member_exist = AirTableMember.all(filter: "ID = #{user.id}")

    if member_exist.empty? 
      member_entry.create 
    else
      Rails.logger.info "User with email '#{@user.email}' already exists in Airtable"
    end
  end
end
