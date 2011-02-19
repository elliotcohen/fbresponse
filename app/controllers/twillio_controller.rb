class TwillioController < ApplicationController

  def create
    #User.send_text(params[:From], params[:Body])
    redirect_to :success
  end
  
  def index
    User.send_text('4124179460', 'Send an awesome test message')
    render :template => 'twillio/hello'
  end
  
  def success
    render :template => 'twillio/hello'
  end
end
