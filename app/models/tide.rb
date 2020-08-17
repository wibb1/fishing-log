class Tide < ApplicationRecord
  validates :date, presence: true

  belongs_to :trip
end