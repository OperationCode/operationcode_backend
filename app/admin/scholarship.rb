ActiveAdmin.register Scholarship do
  permit_params :name, :description, :location, :terms, :open_time, :close_time, :created_at, :updated_at
  index do
    selectable_column
    id_column

    column :name
    column :description
    column :location
    column :terms
    column :open_time
    column :close_time
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :location
      f.input :terms
      f.input :open_time
      f.input :close_time
    end

    f.actions
  end
end
