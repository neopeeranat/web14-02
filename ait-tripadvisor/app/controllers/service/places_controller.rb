class Service::PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /places
  # GET /places.json
  def index

    #hide all place in session[:hide_id]
    if session[:hide_id].nil?
      @places = Place.all
    else
      @places = Place.where.not(id: session[:hide_id])
    end

    #After filter by session[:hide_id], search by check in quote and author columns
    if !params[:search].blank?
      @places = @places.search(params[:search])
      @search = params[:search]
    end

    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @places }
      format.xml { render :xml => @places }
    end
  end

  def search
    @places = Place.where('quote LIKE ?', '%#{params[:q]}%')
    redirect_to :back
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
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

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name,:description)
    end
end