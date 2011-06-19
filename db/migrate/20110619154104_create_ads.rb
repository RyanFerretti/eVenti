class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.text :contents
      t.references :ad_group

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
