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
    ##################################################################
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    ####################################################################
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
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
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    accessible = [ :name, :email ] # extend with your own params
    accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end
