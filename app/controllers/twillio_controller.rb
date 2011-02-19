class TwillioController < ApplicationController

  def create
    render :template => 'hello'
  end
  
  def index
    render :template => 'twillio/hello'
  end
  
end
