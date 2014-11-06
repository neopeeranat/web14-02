class ServiceController < ApplicationController
  included Place
  def index

  end
  def search
    #@dist = Place.find_by(name: params[:destination])
    @dists = Place.where("id like ?","%#{params[:txtDestination]}%")
    #@type = Transportation.find(params[:transportation][:id])
     @dists.each do |row|
      if !Direction.find_by_destination_id(row.id).nil?
        @sdist = row
        @directions = Direction.find_by_sql("select * from directions where destination_id="+"#{row.id}")
      end
     end
  end
end
