class AstroSerializer < ActiveModel::Serializer
  attributes :id, :astronomicalDawn, :astronomicalDusk, :civilDawn, :civilDusk, :moonFraction, :moonPhase, :moonrise, :moonset, :sunset, :sunrise, :date 
end
