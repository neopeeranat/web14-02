class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :banned?

  def admin_only_authorize
    if !current_user.admin?
      flash[:error] = "Form is invalid"
      redirect_to root_path
    end
  end



  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "This account has been suspended...."
      flash[:notice] = nil
      root_path
    end
  end
end
