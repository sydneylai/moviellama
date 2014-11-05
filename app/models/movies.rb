class Movies < ActiveRecord::Base
		has_many :ratings, :sources
end
