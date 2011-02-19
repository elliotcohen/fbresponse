class CanvasController < ApplicationController
  before_filter :sign_user_in

  def index
    @user = User.find_for_facebook_oauth(params[:signed_request])
#    if !signed_in
#      redirect_to 'https://www.facebook.com/dialog/oauth?client_id=135742356491626&redirect_uri=http://http://smooth-meadow-728.heroku.com/canvas/'
#    else
  end
end