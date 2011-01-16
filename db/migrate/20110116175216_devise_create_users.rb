class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.trackable
      t.token_authenticatable
      t.lockable :lock_strategy => :none, :unlock_strategy => :none
      t.string :login
      t.string :role, :null => false, :default => 'normal'
      t.string :name
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :login,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
