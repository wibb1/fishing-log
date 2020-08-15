class Astro < ApplicationRecord
  validates :time, presence: true
  validates :astronomicalDawn, presence: true
  validates :astronomicalDusk, presence: true
  validates :civilDawn, presence: true
  validates :civilDusk, presence: true
  validates :moonFraction, presence: true
  validates :moonPhase, presence: true
  validates :moonrise, presence: true
  validates :moonset, presence: true
  validates :sunset, presence: true
  validates :sunrise, presence: true

  belongs_to :trip
end