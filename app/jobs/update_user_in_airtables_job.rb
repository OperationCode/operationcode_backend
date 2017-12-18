class UpdateUserInAirtablesJob < ActiveJob::Base
  queue_as :default

  Airrecord.api_key = OperationCode.fetch_secret_with(name: :airtable_api_key)

  def perform(user)
    @user = user

    member_array = AirTableMember.all(filter: "ID = #{user.id}")

    if member_array.empty?
      AddUserToAirtablesJob.perform_later(user)
    else
      member = member_array.first
      member[:first_name] = user.first_name
      member[:last_name] = user.last_name
      member[:slack_name] = user.slack_name
      member[:education] = user.education
      member[:employment_status] = user.employment_status
      member[:zip] = user.zip

      member.save
    end
  end

end
