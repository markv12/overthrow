class User < ActiveRecord::Base
  has_many :game_user_connections
  has_many :games, through: :game_user_connections

  acts_as_authentic do |c|
    c.login_field = 'email'
  end

end
