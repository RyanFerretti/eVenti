class CreateHistoricalRatings < ActiveRecord::Migration
  def self.up
    create_table :historical_ratings do |t|
      t.references :member
      t.integer :year
      t.float :total

      t.timestamps
    end
  end

  def self.down
    drop_table :historical_ratings
  end
end
