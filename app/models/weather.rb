class Weather < ApplicationRecord
  validates :time, presence: true
  validates :time, presence: true
 
  belongs_to :trip
end
