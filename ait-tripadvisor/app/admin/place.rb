ActiveAdmin.register Place do
  #validates :name, :descriptions
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

index do
  column :id
  column :name
  column :description
  actions
end
controller do
  def validates(place)
    if(place.name.nil?)
      flash[:name] = "Please enter the name entry"
    end
    else if(place.description.nil?)
           flash[:notice] = "Enter the description for place please"
         end
  end
  def create
    @place = Place.new(permit_params)
    if @place.save
      redirect_to admin_place_path(@place)
    else
      flash[:notice]="Enter the name and description for the place"
      redirect_to new_admin_place_path
    end
  end
  def update
    @place = Place.find(params[:id])
    @place.update(permit_params)
    redirect_to admin_place_path(@place)
  end
  def permit_params
    params.require(:place).permit(:name, :description)
  end
end

end
