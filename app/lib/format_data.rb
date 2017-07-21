class FormatData

  # Converts a comma-separated string into an array of its contents.
  #
  # @param comma_separated_string [String] String of comma-separated values, i.e '80123, 80202'
  # @return [Array] An array of strings, i.e. ['80123', '80202']
  #
  def self.csv_to_array(comma_separated_string)
    comma_separated_string.split(',').map(&:strip)
  end
end
