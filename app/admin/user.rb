ActiveAdmin.register User do
  permit_params :id, :email, :zip, :latitude, :longitude, :created_at, :updated_at,
    :encrypted_password, :reset_password_token, :reset_password_sent_at,
    :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
    :current_sign_in_ip, :last_sign_in_ip, :mentor, :slack_name, :first_name,
    :last_name, :timezone, :bio, :verified, :state, :address_1, :address_2, :city,
    :username, :volunteer, :branch_of_service, :years_of_service, :pay_grade,
    :military_occupational_specialty, :github, :twitter, :linkedin, :employment_status,
    :education, :company_role, :company_name, :education_level, :interests

  scope :all
  scope :mentors
  scope :verified

  index do
    selectable_column
    column :id
    column :email
    column :zip
    column :created_at
    column :sign_in_count
    column :last_sign_in_at
    column :mentor
    column :slack_name
    column :first_name
    column :last_name
    column :timezone
    column :bio
    column :verified
    column :state
    column :city
    column :username
    column :volunteer
    column :branch_of_service
    column :years_of_service
    column :pay_grade
    column :military_occupational_specialty
    column :github
    column :twitter
    column :linkedin
    column :employment_status
    column :education
    column :company_role
    column :company_name
    column :education_level
    column :interests
    actions
  end

  preserve_default_filters!
  filter :state, as: :select, collection: ->{ User.uniq_states }
end
