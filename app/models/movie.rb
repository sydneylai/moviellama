class Movie < ActiveRecord::Base
	has_many :rating
	has_many :source

	def self.obtain q
  	url = "http://omdbapi.com/?s=" + q
  	@response = HTTParty.get(URI.encode(url))
  	@result = JSON.parse(@response.body)

  	if @result["Search"]==nil
  		return {:error => "The request failed :'( "}
  	end

  	@result["Search"].each do |result|

	  	if self.exists?(title: result["Title"]) and self.exists?(year: result["Year"])
	  		@movie = Movie.where(["title = ? ", result["Title"] ]).first
	  	else
	  		url = "http://omdbapi.com/?tomatoes=true&i=" + result["imdbID"]
	  		_r = HTTParty.get(URI.encode(url))
	  		_r = JSON.parse(_r.body)
	  		if(_r["Type"]!="movie")
  				next
  			end
  			oscars = _r["Awards"].match(/(?<wins>[\d]+)\s+(o|Oscar)/)
  			oscars = ((oscars == nil || oscars["wins"] == nil) ? 0 : oscars["wins"])
				@movie = Movie.create({:title => _r["Title"],:year => _r["Year"],:release_date => _r["Released"],:genre => _r["Genre"],:poster_url => _r["Poster"],:plot => _r["Plot"],:runtime => _r["Runtime"] , :oscars => oscars, :imdbid => _r["imdbID"]})  		
				@movie.rating.create( {:source => "imdb", :rating => _r["imdbRating"]})
  			@movie.rating.create( {:source => "rt", :rating => _r["tomatoMeter"]})
  		end
  		self.feedSources @movie
  	end

  	return {:error => "" , :result => "Added	 new movies :) "}
	end

	def llamaRating 
		imdbscore = self.rating.where("source = ?", "imdb").first
		rtscore = self.rating.where("source = ?", "rt").first

		if imdbscore == nil or rtscore == nil
			return "Llama doesn't know" 
		elsif imdbscore.rating > 7.0 and rtscore.rating > 80
			return "Llama pass!"
		else
			return "Llama fail!"
		end
	end

	def self.feedSources m
		return true
		if m.imdbid ==nil
			return false
		end
		url = "http://www.imdb.com/title/"+m.imdbid+"/"
		response = HTTParty.get(URI.encode(url))
		_url = (response.body).match(/\shref="(?<url>\/offsite\/\?.*watch-piv&token=[A-z0-9]*[^"]+)/i)
		if _url != nil and _url["url"] != nil
			m.source.create({:name => 'amazon-prime', :url =>_url["url"]})
		end		
	end

	def self.obtainOld(q)
		url = "http://omdbapi.com/?t=" + q
  	@response = HTTParty.get(URI.encode(url))

  	@result = JSON.parse(@response.body)

  	if @result["Title"] == nil
  		return {:error => "No such llama :("}
  	end

  	if self.exists?(title: @result["Title"]) and self.exists?(year: @result["Year"])
  		return {:error => "" , :result => "Already in DB :) "}
		end
		
		oscars = @result["Awards"].match(/(?<wins>[\d]+)\s+(o|Oscar)/)
		self.create({:title => @result["Title"],:year => @result["Year"],:release_date => @result["Released"],:genre => @result["Genre"],:poster_url => @result["Poster"],:plot => @result["Plot"],:runtime => @result["Runtime"], :oscars => oscars })
		

  	
  	return {:error => "" , :result => "Added new movie :) "}

	end
end
