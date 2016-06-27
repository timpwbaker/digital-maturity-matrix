class Matrix < ActiveRecord::Base
	has_many :questions

	def self.digital_maturity_areas
	    [
	      "Technology",
	      "Channels & Devices",
	      "Audiences",
	      "User Experience",
	      "Content",
	      "Campaigns",
	      "Analytics",
	      "Governance",
	    ]
  	end

end
