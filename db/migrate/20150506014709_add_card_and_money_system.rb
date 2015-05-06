class AddCardAndMoneySystem < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :name
      t.text :description
      t.timestamps
    end

    create_table :user_game_card_connections do |t|
      t.belongs_to :card
      t.belongs_to :game_user_connections
      t.boolean  :overthrown, default: false
      t.timestamps
    end

    change_table :game_user_connections do |t|
      t.integer :money, :default => 0, null: false
    end
  end
end
