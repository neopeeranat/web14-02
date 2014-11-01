class Service::DirectionsController < ApplicationController
  before_action :set_direction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /directions
  # GET /directions.json
  def index

    #hide all direction in session[:hide_id]
    if session[:hide_id].nil?
      @directions = Direction.all
    else
      @directions = Direction.where.not(id: session[:hide_id])
    end

    #After filter by session[:hide_id], search by check in quote and author columns
    if !params[:search].blank?
      @directions = @directions.search(params[:search])
      @search = params[:search]
    end

    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @directions }
      format.xml { render :xml => @directions }
    end
  end

  # GET /directions/1
  # GET /directions/1.json
  def show
  end

  # GET /directions/new
  def new
    @direction = Direction.new
  end

  # GET /directions/1/edit
  def edit
  end

  # POST /directions
  # POST /directions.json
  def create
    @direction = Direction.new(direction_params)
    @direction.origin = Place.find_by(name: 'AIT')
    @direction.created_by = current_user
    respond_to do |format|
      if @direction.save
        format.html { redirect_to service_path, notice: 'direction was successfully created.' }
        format.json { render :show, status: :created, location: [:service, @direction] }
      else
        format.html { render :new }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /directions/1
  # PATCH/PUT /directions/1.json
  def update
    respond_to do |format|
      if @direction.update(direction_params)
        format.html { redirect_to [:service, @direction], notice: 'direction was successfully updated.' }
        format.json { render :show, status: :ok, location: [:service, @direction] }
      else
        format.html { render :edit }
        format.json { render json: @direction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directions/1
  # DELETE /directions/1.json
  def destroy
    @direction.destroy
    respond_to do |format|
      format.html { redirect_to directions_url, notice: 'direction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direction
      @direction = Direction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direction_params
      params.require(:direction).permit(:destination_id, :transportation_id, :price)
    end
end
