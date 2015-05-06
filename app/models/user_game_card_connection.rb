class UserGameCardConnection < ActiveRecord::Base
  belongs_to :card
  belongs_to :game_user_connection
end