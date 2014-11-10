class ServiceController < ApplicationController
  included Place
  def index
   #@dists = Place.first.description
  end
  def details
    @direction = Direction.find(params[:id])
  end
  def search
    #@dists = Place.where("name like ?%#{params[:txtDestination]}%")
    #@type = Transportation.find(params[:transportation][:id])
    if(!params[:Destination].blank?)
      @dists = Place.find_by_name(params[:Destination])
      @directions = Direction.find_by_sql("select * from directions where destination_id=#{@dists.id}")
    else
      flash[:notice]="Enter your destination please"
      redirect_to service_url
    end


=begin
    respond_to do |format|
      format.js {render 'search', locals: @directions }
    end
    #render js: @directions
=end
  end
end
