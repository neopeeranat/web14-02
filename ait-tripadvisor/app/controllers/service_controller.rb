class ServiceController < ApplicationController
  included Place
  def index
   #@dists = Place.first.description
  end
  def details

  end
  def search
    #@dists = Place.where("name like ?%#{params[:txtDestination]}%")
    @type = Transportation.find(params[:transportation][:id])
    @dists = Place.find(params[:txtDestination])
    @directions = Direction.find_by_sql("select * from directions where destination_id=#{@dists.id}")
=begin
    respond_to do |format|
      format.js {render 'search', locals: @directions }
    end
    #render js: @directions
=end
  end
end
