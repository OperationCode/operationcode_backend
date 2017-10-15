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

  ## Action Items
  ## https://activeadmin.info/8-custom-actions.html#action-items

  action_item :community_leader, only: :show do
    link_to 'Community Leader', community_leader_admin_user_path(user), method: :put if !user.has_tag?(User::LEADER)
  end

  action_item :non_community_leader, only: :show do
    link_to 'Remove Community Leader', non_community_leader_admin_user_path(user), method: :put if user.has_tag?(User::LEADER)
  end

  ## Member Actions
  ## https://activeadmin.info/8-custom-actions.html#member-actions

  member_action :community_leader, method: :put do
    user = User.find(params[:id])

    user.tag_list.add User::LEADER
    user.save!

    redirect_to admin_user_path(user), notice: "#{user.first_name} is now a #{User::LEADER}!"
  end

  member_action :non_community_leader, method: :put do
    user = User.find(params[:id])

    user.tag_list.remove User::LEADER
    user.save!

    redirect_to admin_user_path(user), notice: "#{user.first_name} is no longer a #{User::LEADER}"
  end

  ## Index as a Table
  ## https://activeadmin.info/3-index-pages/index-as-table.html

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
  remove_filter :tags
  remove_filter :base_tags
  remove_filter :taggings
  remove_filter :tag_taggings
  filter :with_tags, label: 'Tagged With', as: :select, collection: ->{ User.all_tag_names }
end
