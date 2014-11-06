class HomeController < ApplicationController
  def index
  	@q = params[:q]
  	if(@q == "" || @q == nil)
  		@movies = Movie.all
  	else
  		Movie.obtain(@q)
  		@movies =  Movie.where("lower(title) like ?", "%#{@q}%")
  	end
  	render json: @movies[0]
  end

 
end