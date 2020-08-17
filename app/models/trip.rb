class Trip < ApplicationRecord
  validates :name, presence: true
  validates :success, presence: true
  validates :species, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :time, presence: true
  validates :date, presence: true

  belongs_to :user
  has_one :tide
  has_one :weather 
  has_one :astro

end
