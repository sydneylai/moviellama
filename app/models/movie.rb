class Movie < ActiveRecord::Base
	has_many :rating
	has_many :source
end
