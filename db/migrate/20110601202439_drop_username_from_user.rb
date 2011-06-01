class DropUsernameFromUser < ActiveRecord::Migration
  def self.up
    remove_index :users, :username
    remove_column :users, :username
  end

  def self.down
    add_column :users, :username, :string
    add_index :users, :username, :unique => true
  end
end
