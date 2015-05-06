class AddNameToGame < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.text :name, :default => 'unnamed', null: false
    end
  end
end
