class UpdateRatings < ActiveRecord::Migration
  def self.up
    change_column :ratings, :member_id, :integer
    add_index :ratings, :member_id
  end

  def self.down
  end
end
