class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :success, :species, :body, :latitude, :longitude, :date, :time, :shared, :tide, :weather, :astro, :user

end
