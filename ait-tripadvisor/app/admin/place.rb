ActiveAdmin.register Place do
  #has_many :driecions
  #default_actions :except => [:delete, :edit]
  #actions :all, except: [:edit, :destroy, :show]
  #default_actions
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
index do
  #column :id
  column :name
  column :description
  actions
end
end
