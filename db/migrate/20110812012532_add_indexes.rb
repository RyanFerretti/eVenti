class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :users, :email, :unique => true
    add_index :users, :profile_name, :unique => true
    add_index :locations, :city, :unique => true
    add_index :pictures, :member_id
    add_index :member_summaries, :member_id, :unique => true
    add_index :member_summaries, :location_id
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :profile_name
    remove_index :locations, :city
    remove_index :pictures, :member_id
    remove_index :member_summaries, :member_id
    remove_index :member_summaries, :location_id
  end
end
