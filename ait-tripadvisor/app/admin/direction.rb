ActiveAdmin.register Direction do
  batch_action :destroy, false

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
#filter :name, :as =>:select, :on, :place

  index do
    column :id
    column :price
    actions
  end
  controller do
    def create
      @direction = Direction.create(permit_params)
      if @direction.save
         redirect_to admin_direction_path(@direction)
      else
        flash[:notice] = "Please enter the Required Information"
        redirect_to new_admin_direction_path
      end
    end
    def update
      @direction = Direction.find(params[:id])
      @direction.update(permit_params)
      redirect_to admin_direction_path(@direction)
    end
    def validations
      Direction.create(:name).valid?
    end
    def permit_params
      params.require(:direction).permit(:origin_id, :destination_id, :transportation_id, :user_id, :price, :description)
    end
  end

end
