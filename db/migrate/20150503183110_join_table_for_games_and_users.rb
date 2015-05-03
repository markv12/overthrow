class JoinTableForGamesAndUsers < ActiveRecord::Migration
  def change
    create_table :game_user_connections do |t|
      t.belongs_to :game
      t.belongs_to :user
      t.timestamps
    end
  end
end
