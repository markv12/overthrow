class Game < ActiveRecord::Base
  has_many :game_user_connections
  has_many :users, through: :game_user_connections
  belongs_to :current_turn_user, :class_name => "User", :foreign_key => "current_turn_user_id"
  after_save :notify_state_change

  def notify_state_change
    self.class.connection.execute "NOTIFY #{channel}"
  end

  def on_state_change
    self.class.connection.execute "LISTEN #{channel}"
    loop do
      self.class.connection.raw_connection.wait_for_notify do |event, pid, game|
        yield game
      end
    end
  ensure
    self.class.connection.execute "UNLISTEN #{channel}"
  end

  private
  def channel
    "game_#{id}"
  end
end
