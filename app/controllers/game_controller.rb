class GameController < ApplicationController
  include ActionController::Live

  def show
    @game = Game.find(params[:id])
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    @game = Game.find(params[:id])

    Thread::new do
      loop do
        send_game_status
        sleep 70
      end
    end

    @game.on_state_change do |game|
      send_game_status
    end
  rescue IOError
    logger.info "Stream Has Closed"
  ensure
    response.stream.close
  end

  def join
    @game = Game.find(params[:id])
    @game.users << current_user
    @game.save!
    redirect_to show_game_path(@game)
  end

  private

  def send_game_status
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

end
