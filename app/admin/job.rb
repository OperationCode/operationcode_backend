ActiveAdmin.register Job do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :source_url, :source, :city, :state, :country, :description, :status, :remote

  index do
    selectable_column
    id_column

    column :title
    column :source_url
    column :source
    column :city
    column :state
    column :country
    column :description
    column :status
    column :remote

    actions
  end
end
