class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,  presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true     

  has_many :trips
end
