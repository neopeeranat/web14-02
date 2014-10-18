ActiveAdmin.register User do

  permit_params :name, :email, :password, :password_confirmation, :admin
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
  filter :name
  filter :email
  filter :admin

  config.sort_order = "id_asc"
  index do
    column "ID" , :sortable => :id do |user|
      link_to user.id, admin_user_path(user)

    end
    column :name
    column :email
    column :last_sign_in_at
    column :admin
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin, :label => "Administrator", :as => :boolean
    end
    f.actions
  end
  # form do |f|
  #   f.inputs "Admin Details" do
  #     f.input :email
  #   end
  #   f.actions
  # end

  controller do
    def update_resource(object, attributes)
      update_method = attributes.first[:password].present? ? :update_attributes : :update_without_password
      object.send(update_method, *attributes)
    end
  end

end
