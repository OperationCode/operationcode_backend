ActiveAdmin.register Location do
  permit_params :va_accepted, :address1, :address2, :city, :state, :zip, :code_school_id

  index do
    selectable_column
    id_column

    column 'Code School' do |location|
      location.code_school.name
    end

    column :va_accepted
    column :address1
    column :address2
    column :city
    column :state
    column :zip
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :code_school_id, label: 'Code School', as: :select, collection: CodeSchool.all.order(:name).map { |school| [school.name, school.id]}, include_blank: false
      f.input :va_accepted
      f.input :address1
      f.input :address2
      f.input :city
      f.input :state
      f.input :zip
    end

    f.actions
  end
end
