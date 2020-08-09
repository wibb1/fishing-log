class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :body, :success, :shared, :species, :user_id
end
