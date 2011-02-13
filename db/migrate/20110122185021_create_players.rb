class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.lockable :lock_strategy => :none, :unlock_strategy => :none
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
