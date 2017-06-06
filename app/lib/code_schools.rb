class CodeSchools
  def self.all(config = Rails.root + 'config/code_schools.yml')
    YAML.load_file(config)
  end
end
