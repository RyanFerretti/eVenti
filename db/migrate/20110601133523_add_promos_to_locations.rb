class AddPromosToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :promos, :text
    add_column :locations, :advertisements, :text
  end

  def self.down
    remove_column :locations, :promos
    remove_column :locations, :advertisements
  end
end
