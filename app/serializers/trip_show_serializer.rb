class TripShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :success, :species, :body, :latitude, :longitude, :date, :time, :shared, :tide, :weather, :astro, :user

  belongs_to :user, if: :current_user?

  def current_user?
    current_user == object.user
  end
end
