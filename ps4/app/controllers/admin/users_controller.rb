class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only_authorize

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to admin_path, :notice => "User updated."
    else
      redirect_to admin_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_path, :notice => "User deleted."
  end

  def secure_params
    params.require(:user).permit(:role_id,:banned)
  end
end
