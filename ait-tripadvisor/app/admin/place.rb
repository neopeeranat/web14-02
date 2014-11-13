ActiveAdmin.register Place do
  batch_action :destroy, false

index do
  column :id
  column :name
  column :description
  actions
end

 filter :origins
 filter :destinations
 filter :name
 filter :description

controller do
  def validates(place)
    if(place.name.nil?)
      flash[:name] = "Please enter the name entry"
    elsif(place.description.nil?)
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
