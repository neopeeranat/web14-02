ActiveAdmin.register Transportation do
  batch_action :destroy, false
=begin
  ActiveAdmin.register_page "My Page" do
    content do
      para "Hello World"
    end
  end
=end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model

  #permit_params :type


  #filter :type, :as => :select, :collection => proc {Transportation.type}
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


  index do
    column :id
    column :type
    actions
  end
  #filter :directions, :as => :check_boxes
  filter :type
  filter :created_at
  filter :updated_at

  sidebar 'Transporations', :only => :show do
    table_for Transportation.joins(:directions).where(:transportation_id => Transportation.id) do |t|
      t.column("transportation_id") { |transport| transport.id }
    end
  end


  controller do
   def create
     @transport = Transportation.new(permit_params)
     if @transport.save
        redirect_to admin_transportation_path(@transport)
     else
       flash[:notice] = "Please enter the type for transport"
       redirect_to new_admin_transportation_path
     end

   end
   def update
     @transport = Transportation.find(params[:id])
     @transport.update(permit_params)
     redirect_to admin_transportation_path(@transport)
   end
   def permit_params
     params.require(:transportation).permit(:type)
   end
 end
end
