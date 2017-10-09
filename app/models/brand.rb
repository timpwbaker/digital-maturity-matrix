class Brand < ApplicationRecord
  belongs_to :user

  validates :color_a, presence: true
  validates :color_b, presence: true
end
