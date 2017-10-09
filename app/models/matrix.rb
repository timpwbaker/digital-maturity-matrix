class Matrix < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :submissions, dependent: :destroy

  validates :name, presence: true

  DIGITAL_MATURITY_AREAS = [
    'Technology',
    'Channels & Devices',
    'Audiences',
    'User Experience',
    'Content',
    'Campaigns',
    'Analytics',
    'Governance'
  ]

  def self.digital_maturity_areas
    DIGITAL_MATURITY_AREAS
  end
end
