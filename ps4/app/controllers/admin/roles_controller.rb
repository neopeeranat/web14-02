class Admin::RolesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only_authorize

  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:id])
  end


  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to admin_path, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    role = Role.find(params[:id])
    role.destroy
    redirect_to admin_path, :notice => "Role deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:role_name)
    end
    def secure_params
      params.require(:role).permit(:role)
    end

end
