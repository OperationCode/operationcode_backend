ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role_id

  index do
    selectable_column
    id_column
    column :email

    column 'Role' do |admin_user|
      admin_user.role.title
    end

    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email

      if current_admin_user.role.super_admin?
        f.input :role_id, label: 'Role', as: :select, collection: Role.all.order(:title).map { |role| [role.title, role.id]}, include_blank: false
      end

      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
end
