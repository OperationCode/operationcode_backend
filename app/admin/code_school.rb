ActiveAdmin.register CodeSchool do
  permit_params :name, :url, :logo, :full_time, :hardware_included, :has_online, :online_only, :created_at, :updated_at, :notes, :mooc

  index do
    selectable_column
    id_column

    column :name
    column :url
    column :logo
    column :full_time
    column :hardware_included
    column :has_online
    column :online_only
    column :created_at
    column :updated_at
    column :notes
    column :mooc
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :logo
      f.input :full_time
      f.input :hardware_included
      f.input :has_online
      f.input :online_only
      f.input :created_at
      f.input :updated_at
      f.input :notes
      f.input :mooc
    end

    f.actions
  end
end
