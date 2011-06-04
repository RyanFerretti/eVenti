class AddMoreBands < ActiveRecord::Migration
  def self.up
    remove_column :member_summaries, :top_bands
    add_column :member_summaries, :top_bands_1, :string
    add_column :member_summaries, :top_bands_2, :string
    add_column :member_summaries, :top_bands_3, :string
  end

  def self.down
    add_column :member_summaries, :top_bands, :string
    remove_column :member_summaries, :top_bands_1
    remove_column :member_summaries, :top_bands_2
    remove_column :member_summaries, :top_bands_3
  end
end
