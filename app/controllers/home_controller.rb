class HomeController < ApplicationController
  def index
  	@q = params[:q]
  	if(@q == "" || @q == nil)
  		@movies = Movie.all
  	else
  		Movie.obtain(@q)
  		@movies =  Movie.where("lower(title) like ?", "%#{@q}%")
  	end
  	# render json: @movies
  end

 
end

## need to reset to search bar when going back