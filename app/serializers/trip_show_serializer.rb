class TripShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :success, :shared, :species, :user_id, :latitude, :longitude, :trip_time

  has_many :users
end
