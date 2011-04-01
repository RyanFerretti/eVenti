class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.string :member_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
