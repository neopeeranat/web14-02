class Service::PlacesController < ApplicationController
  before_action :authenticate_user! , except: [:index]

  # GET /places
  # GET /places.json
  def index

    #this for auto-complete search for places
    @places = (params[:q].blank?)? Place.all : Place.where("name ilike ?", "%#{params[:q]}%")

    respond_to do |format|
      #format.html #index.html.erb
      format.json { render json: @places }
      format.xml { render :xml => @places }
    end
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to new_service_direction_path, notice: 'place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name,:description,:category_id,:lat,:lng)
    end
end
