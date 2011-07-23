class UpdateDescriptionColumnsToText < ActiveRecord::Migration
  def self.up
    change_column :member_summaries, :piercing_description, :text
    change_column :member_summaries, :tattoo_description, :text
    change_column :member_summaries, :talent, :text
  end

  def self.down
  end
end
