class Question < ApplicationRecord
  belongs_to :matrix

  def self.digital_maturity_areas
    [
      'Technology',
      'Channels & Devices',
      'Audiences',
      'User Experience',
      'Content',
      'Campaigns',
      'Analytics',
      'Governance'
    ]
  end

  def self.ordered_by_area
    order(:area)
  end
end
