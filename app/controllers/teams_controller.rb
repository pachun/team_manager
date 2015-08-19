class TeamsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Team.all
  end

  def show
    render json: Team.find(params[:id])
  end

  def create
    team = Team.new(team_params)
    if team.save
      render json: team, status: 201
    else
      render json: team, status: :not_acceptable
    end
  end

  def update
    team = Team.find(params[:id])
    if team.update_attributes(team_params)
      render json: team, status: 200
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :city, :ticket_price)
  end
end
