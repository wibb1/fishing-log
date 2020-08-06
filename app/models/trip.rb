class Trip < ApplicationRecord
  validates :name, presence: true
  validates :success, presence: true
  validates :species, presence: true

  belongs_to :user
end
