class HomeController < ApplicationController
  def index
  	@q = params[:q]
  end
end
