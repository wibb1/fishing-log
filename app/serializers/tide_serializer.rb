class TideSerializer < ActiveModel::Serializer
  attributes :id, :first_type, :first_time, :second_type, :second_time, :third_type, :third_time, :fourth_type, :fourth_time, :date
end
