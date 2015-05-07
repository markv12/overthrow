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
        sleep 45
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

  def init_game
    @game = Game.find(params[:id])
    @game.game_user_connections.each{|conn|
      conn.money +=3;
      conn.save!
    }
    @game.save!
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private

  def send_game_status
    Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self)
    Game.uncached do
      @game.reload
      game_users = @game.game_user_connections.includes(:user).map{|conn|
        user_data = Hash.new
        user_data['id'] = conn.user.id
        user_data['name'] = conn.user.name
        user_data['money'] = conn.money
        user_data
      }
      data = {
        game: @game,
        users: game_users,
        me: current_user.id
      }
      data_string = "data: " + data.to_json + "\n\n"
      response.stream.write(data_string)
    end
  end

end
