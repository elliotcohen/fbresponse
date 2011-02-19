class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def sign_user_in
    if user_signed_in?
      return true
    else
      redirect_to '/users/auth/facebook'
    end
  end
end
