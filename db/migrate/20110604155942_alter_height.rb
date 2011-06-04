class AlterHeight < ActiveRecord::Migration
  def self.up
    remove_column :member_summaries, :height
    add_column :member_summaries, :height_feet, :integer
    add_column :member_summaries, :height_inches, :integer
  end

  def self.down
    add_column :member_summaries, :height, :string
    remove_column :member_summaries, :height_feet
    remove_column :member_summaries, :height_inches
  end
end
