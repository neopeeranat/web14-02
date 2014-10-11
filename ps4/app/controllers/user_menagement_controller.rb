class UserMenagementController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :login_required, except: [:index, :show]
  before_action :role_required, except: [:index, :show]

  def index

  end
end
