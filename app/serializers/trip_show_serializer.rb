class TripShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :success, :species, :body, :latitude, :longitude, :date, :time, :shared, :user_id, :tide, :weather, :astro
end
