# For use to insert user information into Airtable
# Using the airrecord gem

class AirTableMember <  Airrecord::Table
  self.base_key = OperationCode.fetch_secret_with(name: :airtable_add_user_base_id)
  self.table_name = OperationCode.fetch_secret_with(name: :airtable_add_user_table_name)
end
