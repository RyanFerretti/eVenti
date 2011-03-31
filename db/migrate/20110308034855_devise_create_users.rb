class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      t.lockable
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :profile_name
      t.string :type # for single table inheritance
      t.timestamps
    end
    add_index :users, :username, :unique => true
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
