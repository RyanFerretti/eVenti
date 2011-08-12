class ReAddRatings < ActiveRecord::Migration
  def self.up
    drop_table :ratings
    create_table :ratings do |t|
      t.references :member
      t.integer :value
      t.timestamps
    end
    add_index :ratings, :member_id
  end

  def self.down
    drop_table :ratings
  end
end
