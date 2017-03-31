class Matrix < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy

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
end
