class Team < ActiveRecord::Base
  validates_presence_of :name, :city, :ticket_price
end
