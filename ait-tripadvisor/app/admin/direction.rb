ActiveAdmin.register Direction do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
#filter :name, :as =>:select, :on, :place
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  index do
    column :id
    column :price
    actions
  end
  controller do
    actions :all, :except => [:delete] # you can decide which all methods to be shown in show page.
  end

end
