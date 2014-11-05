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
  		return render json: {:error => "This llama's already in the system :)"}.to_json
		end

  	@movie.title = @result["Title"]
  	@movie.year = @result["Year"]
  	@movie.release_date = @result["Released"]
  	@movie.genre = @result["Genre"]
  	@movie.poster_url = @result["Poster"]
  	@movie.plot = @result["Plot"]
  	@movie.runtime = @result["Runtime"]
  	@movie.oscars = @result["Awards"]


  	if @movie.save
  		render json: @movie
		else
			render json: {:error => "Llamafail in writing to database :("}.to_json
		end
  end
end


# {
# Title: "Vicky Cristina Barcelona",
# Year: "2008",
# Rated: "PG-13",
# Released: "15 Aug 2008",
# Runtime: "96 min",
# Genre: "Drama, Romance",
# Director: "Woody Allen",
# Writer: "Woody Allen",
# Actors: "Rebecca Hall, Scarlett Johansson, Christopher Evan Welch, Chris Messina",
# Plot: "Two girlfriends on a summer holiday in Spain become enamored with the same painter, unaware that his ex-wife, with whom he has a tempestuous relationship, is about to re-enter the picture.",
# Language: "English, Spanish",
# Country: "Spain, USA",
# Awards: "Won 1 Oscar. Another 32 wins & 38 nominations.",
# Poster: "http://ia.media-imdb.com/images/M/MV5BMTU2NDQ4MTg2MV5BMl5BanBnXkFtZTcwNDUzNjU3MQ@@._V1_SX300.jpg",
# Metascore: "70",
# imdbRating: "7.2",
# imdbVotes: "160,842",
# imdbID: "tt0497465",
# Type: "movie",
# Response: "True"
# }