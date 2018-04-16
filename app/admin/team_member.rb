ActiveAdmin.register TeamMember do
  permit_params :name, :role, :description, :group, :image_src, :email

  index do
    selectable_column
    id_column

    column :name
    column :role
    column :email
    column :created_at
    column :updated_at
    column :description
    column :group
    column :image_src

    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :role
      f.input :email
      f.input :description
      f.input :group
      f.input :image_src
    end

    f.actions
  end
end
