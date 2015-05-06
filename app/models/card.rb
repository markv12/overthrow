class Card < ActiveRecord::Base
  has_many :user_game_card_connections
  has_many :game_user_connections, through: :user_game_card_connections
  after_save :notify_state_change

end
