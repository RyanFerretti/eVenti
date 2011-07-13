class AddActiveToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :active, :boolean, :default => false
  end

  def self.down
    remove_column :locations, :active
  end
end
