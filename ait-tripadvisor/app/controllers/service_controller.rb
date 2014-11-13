class ServiceController < ApplicationController
  $place
  def index

  end
  def details
    @route = Direction.find(params[:format])
  end
  def display
         search
  end
  def search
    #@dists = Place.where("name like ?%#{params[:txtDestination]}%")

    #respond_to do |foramt|
      if(!params[:txtDestination].nil?)
        @dists = Place.find_by_id(params[:txtDestination])
        @type = Transportation.find(params[:transportation][:id])
        #@directions = Direction.find_by_sql("select * from directions where destination_id=#{@dists.id}")
        @directions = Direction.where(destination_id: @dists.id)
        render :display
      elsif params[:txtDestination].nil?
        @dists = Place.find(params[:id])
        @type = Transportation.find(params[:type])
        #@directions = Direction.find_by_sql("select * from directions where destination_id=#{@dists.id}")
        @directions = Direction.where(destination_id: @dists.id)
        render :display
      else
        flash[:notice]="Enter your destination please"
        redirect_to service_url
      end

  end
end
