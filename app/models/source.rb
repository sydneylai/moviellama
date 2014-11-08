class Source < ActiveRecord::Base
	belongs_to :movie

	def getSite
		if self.site == 'amazon'
			return self.site.to_i
		else
			return self.site
		end
	end

	def siteLabel
		dict = {"ams" => "Amazon Stream", "amp" => "Amazon Prime", "bof" => "Box Office" }
		return dict[self.site]
	end
end
