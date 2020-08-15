class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :success, :species, :body, :shared, :latitude, :longitude, :text_date, :tide, :weather, :astro, :user

end
