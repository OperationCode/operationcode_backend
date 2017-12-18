class AirtablesBulkImport
  def self.execute
    User.all.each do |user|
      AddUserToAirtablesJob.perform_later(user)
    end
  end
end
