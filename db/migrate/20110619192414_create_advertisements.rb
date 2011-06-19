class CreateAdvertisements < ActiveRecord::Migration
  def self.up
    create_table :advertisements do |t|
      t.integer :ad_id
      t.integer :location_id
      t.timestamps
    end
  end

  def self.down
    drop_table :advertisements
  end
end
