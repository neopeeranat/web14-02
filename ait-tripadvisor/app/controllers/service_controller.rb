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

      if(!params[:txtDestination].nil?)
        @dists = Place.find_by_id(params[:txtDestination])
        @type = Transportation.find(params[:transportation][:id])
        @directions = Direction.where("destination_id=? AND transportation_id =? ", @dists.id, @type.id)
        render :display
      elsif params[:txtDestination].nil?
        @dists = Place.find(params[:id])
        @type = Transportation.find(params[:type])
        @directions = Direction.where("destination_id=? AND transportation_id =? ", @dists.id, @type.id)
        render :display
      else
        flash[:notice]="Enter your destination please"
        redirect_to service_url
      end

  end

end
