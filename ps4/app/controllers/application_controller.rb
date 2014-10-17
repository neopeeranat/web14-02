class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :banned?, :ensure_signup_complete, only: [:new, :create, :update, :destroy]

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

  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end
