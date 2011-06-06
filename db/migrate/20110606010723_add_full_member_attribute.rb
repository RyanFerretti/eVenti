class AddFullMemberAttribute < ActiveRecord::Migration
  def self.up
    add_column :member_summaries, :staffing, :boolean, :default => true
  end

  def self.down
    remove_column :member_summaries, :staffing
  end
end
