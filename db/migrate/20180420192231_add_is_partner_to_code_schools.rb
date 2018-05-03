class AddIsPartnerToCodeSchools < ActiveRecord::Migration[5.0]
  def change
    add_column :code_schools, :is_partner, :boolean, default: false, null: false
  end
end
