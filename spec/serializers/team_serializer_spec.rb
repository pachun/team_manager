require "rails_helper"

describe TeamSerializer do
  let(:team) do
    FactoryGirl.create(:team, name: "Bruins", city: "Boston", ticket_price: 250)
  end

  subject(:serialized_team) { TeamSerializer.new(team) }

  it "serializes team name" do
    expect(serialized_team.name).to eq(team.name)
  end

  it "serializes team city" do
    expect(serialized_team.city).to eq(team.city)
  end

  it "serializes team ticket price" do
    expect(serialized_team.ticket_price).to eq(team.ticket_price)
  end
end
