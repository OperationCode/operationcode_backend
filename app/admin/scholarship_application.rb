ActiveAdmin.register ScholarshipApplication do
  permit_params :reason, :terms_accepted
  index do
    selectable_column
    id_column

    column 'Scholarship' do |scholarship_app|
      scholarship_app.scholarship.name
    end

    column :reason
    column :terms_accepted

    actions
  end

  form do |f|
    f.inputs do
      f.input :scholarship_id, label: 'Scholarship', as: :select, collection: Scholarship.all.order(:name).map { |scholarship| [scholarship.name, scholarship.id]}, include_blank: false
      f.input :reason
      f.input :terms_accepted
    end

    f.actions
  end

end
