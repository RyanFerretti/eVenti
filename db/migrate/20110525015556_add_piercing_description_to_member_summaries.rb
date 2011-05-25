class AddPiercingDescriptionToMemberSummaries < ActiveRecord::Migration
  def self.up
    add_column :member_summaries, :piercing_description, :string
    add_column :member_summaries, :tattoo_description, :string
  end

  def self.down
    remove_column :member_summaries, :piercing_description
    remove_column :member_summaries, :tattoo_description
  end
end
