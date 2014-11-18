class ServiceController < ApplicationController

  def index
    if !session[:direction_id].nil?
      @directions = Direction.where("destination_id=? AND transportation_id =? ", session[:direction_id], session[:transportation_id]).order(:price)
      session[:direction_id] = nil
      session[:transportation_id] = nil
    end
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
           #render
        else
          flash.now[:alert] = "Please select the transport type"
          #redirect_to service_url
        end
      elsif params[:txtDestination].nil?
        # @dists = Place.find(params[:id])
        # @type = Transportation.find(params[:type])
        # @directions = Direction.where("destination_id=? AND transportation_id =? ", @dists.id, @type.id).order(:price)
        #render :index
        session[:direction_id] = params[:id]
        session[:transportation_id] = params[:type]
        redirect_to service_path
      else
        flash.now[:alert]="Enter your destination please"
        #redirect_to service_url
      end


  end

end
