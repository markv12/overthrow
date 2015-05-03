class GameController < ApplicationController
  include ActionController::Live

  def show
    @game = Game.find(params[:id])
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    @game = Game.find(params[:id])
    @game.on_state_change do |game|
      Game.uncached do
        @game.reload
        game_users = @game.users.pluck(:id, :name)
        data = {
          game: @game,
          users: game_users
        }
        data_string = "data: " + data.to_json + "\n\n"
        response.stream.write(data_string)
      end
    end
  rescue IOError
    logger.info "Stream Has Closed"
  ensure
    response.stream.close
  end

end
