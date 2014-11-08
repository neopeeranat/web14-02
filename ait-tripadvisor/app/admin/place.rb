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
  def create
    @place = Place.new(permit_params)
    @place.save
    redirect_to admin_place_path(@place)
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
