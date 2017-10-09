class Question < ApplicationRecord
  belongs_to :matrix

  validates :body, presence: true
end
