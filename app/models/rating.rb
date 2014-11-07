class Rating < ActiveRecord::Base
	belongs_to :movie

	def getRating
		if self.source == 'rt'
			return self.rating.to_i
		else
			return self.rating
		end
	end

	def ratingLabel
		dict = {"imdb" => "IMDB", "rt" => "Rotten Tomatoes"}
		return dict[self.source]
	end
end