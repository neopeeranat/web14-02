class TransportationController < ApplicationController
  def index
     @transport = Transportation.all
  end
end
