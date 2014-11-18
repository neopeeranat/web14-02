class ServiceController < ApplicationController

  def index

  end
  def details
    @route = Direction.find(params[:format])
  end
  def display
         search
  end
  def search

      if(!params[:txtDestination].blank?)
        @dists = Place.find_by_id(params[:txtDestination])
        if(!params[:transportation][:id].blank?)
           @type = Transportation.find(params[:transportation][:id])
           @directions = Direction.where("destination_id=? AND transportation_id =? ", @dists.id, @type.id).order(:price)
           render
        else
          flash[:alert] = "Please select the transport type"
          redirect_to service_url
        end
      elsif params[:txtDestination].nil?
        @dists = Place.find(params[:id])
        @type = Transportation.find(params[:type])
        @directions = Direction.where("destination_id=? AND transportation_id =? ", @dists.id, @type.id).order(:price)
        render :index
      else
        flash[:alert]="Enter your destination please"
        redirect_to service_url
      end


  end

end
