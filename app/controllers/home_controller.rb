class HomeController < ApplicationController


  def index

    

    
  	@q = params[:q].to_s


    url = "http://omdbapi.com/?t=" + @q
    @response = HTTParty.get(URI.encode(url))

    @ymin = params[:ymin]
    @ymax = params[:ymax]
    @y = params[:y]
    @imdbmin = params[:imdbmin]
    @rtmin = params[:rtmin]
    @movies = Movie
  	if(params[:s]!='search')
  		@movies = @movies.limit(0)
      @home = true
    end
    if(@q != "" and @q != nil)
  		Movie.obtain(@q)
  		@movies =  Movie.where("lower(title) like ? AND lower(genre) not like ? ", "%#{@q}%", "%short%")
  	end
    if @y != "" and @y != nil
      @movies = @movies.yearFilter @y
    end
    if @ymin != "" and @ymin != nil
      @movies = @movies.yearMin @ymin
    end
    if @ymax != "" and @ymax != nil
      @movies = @movies.yearMax @ymax
    end
    if @imdbmin != "" and @imdbmin != nil
      @movies = @movies.minIMDB @imdbmin
    end
    if @rtmin != "" and @rtmin != nil
      @movies = @movies.minRT @rtmin
    end
    @movies = @movies.includes(:rating).where('ratings.source == "imdb"').order('ratings.rating desc')
  end


 
end