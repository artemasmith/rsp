class GamesController < ApplicationController
  def index
    @actions = rule_engine.possible_throws
  end

  def create
    result = game_service.call(game_params[:throw].downcase)

    render json: result
  end

  private

  def game_service
    game_service = GameService.new(rule_engine)
  end

  def rule_engine
    @_rule_engine ||= RuleEngine.new
  end

  def game_params
    params.require(:game).permit(:throw)
  end
end
