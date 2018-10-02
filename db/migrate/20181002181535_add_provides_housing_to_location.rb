class AddProvidesHousingToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :provides_housing, :boolean
  end
end
