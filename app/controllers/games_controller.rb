class GamesController < ApplicationController
  def index
    @actions = RuleEngine.new.possible_throws
  end

  def create
    result = game_service.call(game_params[:throw].downcase)

    render json: { result: result }
  end

  private

  def game_service
    r_e = RuleEngine.new
    game_service = GameService.new(r_e)
  end

  def game_params
    params.require(:game).permit(:throw)
  end
end
