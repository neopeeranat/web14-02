class Users::DirectionsController < ApplicationController
  layout 'users_layout'

  before_action :set_direction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /directions
  # GET /directions.json

  # GET /directions/1/edit
  def edit
    if @direction.created_by != current_user
      flash[:alert]="You cannot modify another user direction"
      redirect_to users_directions_url
    end
  end

  def show
    @social_url = "#{request.protocol}#{request.host_with_port}#{"/ait-tripadvisor"  if Rails.env == 'production'}/service/directions/#{params[:id]}"
    @meta_content_title = "Direction from #{@direction.origin} to #{@direction.destination}. Created by #{@direction.created_by.name}"
  end

  # PATCH/PUT /directions/1
  # PATCH/PUT /directions/1.json
  def update
    if @direction.created_by != current_user
      flash[:alert]="You cannot modify another user direction"
      redirect_to users_directions_url
    else
      respond_to do |format|
        if @direction.update(direction_params)
          format.html { redirect_to users_directions_url, notice: 'direction was successfully updated.' }
          format.json { render :show, status: :ok, location: [:service, @direction] }
        else
          format.html { render :edit }
          format.json { render json: @direction.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /directions/1
  # DELETE /directions/1.json
  def destroy
    if @direction.created_by != current_user
      flash[:alert]="You cannot delete another user direction"
      redirect_to users_directions_url
    else
      @direction.destroy
      respond_to do |format|
        format.html { redirect_to users_directions_url, notice: 'direction was successfully destroyed.' }
        format.json { head :no_content }
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
