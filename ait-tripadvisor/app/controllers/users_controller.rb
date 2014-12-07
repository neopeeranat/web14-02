class UsersController < ApplicationController
  layout "users_layout", except: [:show]

  def index
  end
  def check_email
      @user = User.find_by_email(params[:email])
      respond_to do |format|
        format.json { render :json =>!@user }
      end
  end
  def directions
  end

  def show
    @user = User.find_by(id:params[:id])
    #if can't find user, redirect to prvious page or go to home page
    if @user.nil?
      flash[:alert] = 'Unable to find user'
      redirect_to request.env["HTTP_REFERER"] || root_path
    end
  end
end
