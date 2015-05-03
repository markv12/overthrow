class Game < ActiveRecord::Base
  has_many :game_user_connections
  has_many :users, through: :game_user_connections
  belongs_to :current_turn_user, :class_name => "User", :foreign_key => "current_turn_user_id"

end
