class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_only_authorize
  def index
    @users = User.all.order(:id)
    @roles = Role.all.order(:id)
    @users_recent =User.order("created_at desc").limit(10)
  end


end
