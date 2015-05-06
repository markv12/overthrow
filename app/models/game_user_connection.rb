class GameUserConnection < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  has_many :user_game_card_connections
  has_many :cards, through: :user_game_card_connections
end