class HomeController < ApplicationController
  def index
  	@q = params[:q]
  	if(@q == "" || @q == nil)
  		@movies = Movie.all
  	else
  		@movies = Movie.where("title like ? ", "%#{@q}%")
  	end
  	render json: @movies
  end

end
