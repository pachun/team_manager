require "rails_helper"

describe TeamsController do
  before do
    FactoryGirl.create(:team, name: "Bruins", city: "Boston", ticket_price: 250)
    FactoryGirl.create(:team, name: "Devils", city: "New Jersey", ticket_price: 50)
    FactoryGirl.create(:team, name: "Maple Leafs", city: "Torronto", ticket_price: 50)
    FactoryGirl.create(:team, name: "Thrashers", city: "Atlanta", ticket_price: 25)
  end

  describe "GET index" do
    it "succeeds" do
      get :index
      expect(response.status).to eq(200)
    end

    it "returns the list of teams" do
      get :index
      retrieved_teams = JSON.parse(response.body)["teams"]

      expect(retrieved_teams.count).to eq(Team.all.count)
    end
  end

  describe "GET show" do
    it "returns the requested team" do
      get :show, id: 2
      retrieved_team = JSON.parse(response.body)["team"]
      team = Team.find(2)

      expect(retrieved_team["name"]).to eq(team.name)
      expect(retrieved_team["city"]).to eq(team.city)
      expect(retrieved_team["ticket_price"]).to eq(team.ticket_price)
    end

    it "returns '404, not found' if the requested team doesn't exist" do
      assert_raises(ActiveRecord::RecordNotFound) do
        get :show, id: (Team.all.count + 1)
      end
    end
  end

  describe "POST create" do
    it "creates a new team" do
      count_prior_to_create = Team.all.count
      team = {
        team: {
          name: "Canadians",
          city: "Montreal",
          ticket_price: 200,
        }
      }
      post :create, team

      expect(response.status).to eq(201)
      expect(Team.all.count).to eq(count_prior_to_create + 1)
    end

    it "returns '406, not acceptable' if the team is invalid" do
      count_prior_to_create = Team.all.count
      team = {
        team: {
          name: "Canadians",
          city: "Montreal",
        }
      }
      post :create, team

      expect(response.status).to eq(406)
      expect(Team.all.count).to eq(count_prior_to_create)
    end
  end

  describe "PUT update" do
    it "updates resources by id" do
      replaced_team = Team.find_by(name: "Thrashers")
      team = {
        id: replaced_team.id,
        name: "Jets",
        city: "Winnipeg",
        ticket_price: 75,
      }
      put :update, id: replaced_team.id, team: team

      expect(response.status).to eq(200)
      expect(Team.all.select { |t| t.city == "Atlanta" }.count).to eq(0)
      expect(Team.all.select { |t| t.city == "Winnipeg" }.count).to eq(1)
    end

    it "updates resources by id" do
      invalid_team_id = (Team.all.count + 1)
      team = {
        id: invalid_team_id,
        name: "Jets",
        city: "Winnipeg",
        ticket_price: 75,
      }
      assert_raises(ActiveRecord::RecordNotFound) do
        put :update, id: invalid_team_id, team: team
      end
    end
  end
end
