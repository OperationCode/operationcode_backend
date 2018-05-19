ActiveAdmin.register ScholarshipApplication do
  permit_params :reason, :terms_accepted, :scholarship_id, :user_id
  index do
    selectable_column
    id_column

    column 'Scholarship' do |scholarship_id|
      scholarship_id.scholarship.name
    end

    column 'User' do |user_id|
      user_id.user.name
    end

    column :reason
    column :terms_accepted
    column :scholarship_id
    column :user_id
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :scholarship_id, label: 'Scholarship', as: :select, collection: Scholarship.all.order(:name).map { |scholarship| [scholarship.name, scholarship.id] }, include_blank: false
      f.input :user_id, label: 'User', as: :select, collection: User.verified.order(:last_name).map { |user| [user.name, user.id] }, include_blank: false
      f.input :reason
      f.input :terms_accepted
    end

    f.actions
  end
end
