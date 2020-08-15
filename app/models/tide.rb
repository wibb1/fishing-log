class Tide < ApplicationRecord
  validates :date, presence: true
  validates :first_type, presence: true
  validates :first_time, presence: true
  validates :second_type, presence: true
  validates :second_time, presence: true
  validates :third_type, presence: true
  validates :third_time, presence: true
  validates :fourth_type, presence: true
  validates :fourth_time, presence: true

  belongs_to :trip
end