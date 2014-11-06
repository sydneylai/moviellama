class ScraperController < ApplicationController
  def scrape
  	url = "http://omdbapi.com/?t=" + params[:title]
  	@response = HTTParty.get(URI.encode(url))

  	@movie = Movie.new
  	@result = JSON.parse(@response.body)

  	if @result["Title"] == nil
  		return render json: {:error => "No such llama :("}.to_json
  	end

  	if Movie.exists?(title: @result["Title"]) and Movie.exists?(year: @result["Year"])
  		@movie = Movie.where("title = ?", @result["Title"]).first
		end

		oscars = @result["Awards"].match(/(?<wins>[\d]+)\s+(o|Oscar)/)
		@movie.oscars = ((oscars == nil || oscars["wins"] == nil) ? 0 : oscars["wins"])

  	@movie.title = @result["Title"]
  	@movie.year = @result["Year"]
  	@movie.release_date = @result["Released"]
  	@movie.genre = @result["Genre"]
  	@movie.poster_url = @result["Poster"]
  	@movie.plot = @result["Plot"]
  	@movie.runtime = @result["Runtime"]
  	
  	if @movie.save
  		render json: @movie
		else
			render json: {:error => "Llamafail in writing to database :("}.to_json
		end
  end
end