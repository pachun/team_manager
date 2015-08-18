class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :ticket_price
end
