class AddContactInfoToMemberSummary < ActiveRecord::Migration
  def self.up
    add_column :member_summaries, :cell_phone, :string
    add_column :member_summaries, :address_more, :string
  end

  def self.down
    remove_column :member_summaries, :cell_phone
    remove_column :member_summaries, :address_more
  end
end
