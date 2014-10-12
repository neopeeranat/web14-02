class UserMenagementController < ApplicationController

  before_filter :authenticate_user!, :except => [:index]
  before_action :login_required, except: [:index]
  before_action :role_required, except: [:index]

  def index

  end
  def show
    render :text =>  'Show method is not mentions in view part of Rails'
  end
end
