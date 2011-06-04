class AddPhysicalAttributes < ActiveRecord::Migration
  def self.up
    add_column :member_summaries, :experience, :text
    add_column :member_summaries, :eyes, :string
    add_column :member_summaries, :eyes_other, :string
    add_column :member_summaries, :ethnicity, :string
    add_column :member_summaries, :ethnicity_other, :string
  end

  def self.down
    remove_column :member_summaries, :experience
    remove_column :member_summaries, :eyes
    remove_column :member_summaries, :eyes_other
    remove_column :member_summaries, :ethnicity
    remove_column :member_summaries, :ethnicity_other
  end
end
