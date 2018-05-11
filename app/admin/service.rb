ActiveAdmin.register Service do
  permit_params :name

  index do
    selectable_column
    id_column

    column :name
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end
end
