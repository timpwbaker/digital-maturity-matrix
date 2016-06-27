class Question < ActiveRecord::Base
  belongs_to :matrix

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
