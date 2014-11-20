class Service::DirectionsController < ApplicationController
  before_action :authenticate_user!, execpt: [:show]
  before_action :set_direction, only: [:show]

  # GET /directions
  # GET /directions.json
  def index

    @directions = Direction.all
    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @directions }
      format.xml { render :xml => @directions }
    end
  end

  def show
    @meta_content_title = "Direction from #{@direction.origin} to #{@direction.destination}. Created by #{@direction.created_by.name}"
  end
  # GET /directions/new
  def new
    @direction = Direction.new
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direction
      @direction = Direction.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def direction_params
      params.require(:direction).permit(:destination_id, :transportation_id, :price, :description)
    end
end
