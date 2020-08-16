class Astro < ApplicationRecord
  validates :time, presence: true

  belongs_to :trip
end