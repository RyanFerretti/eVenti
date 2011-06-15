class AddCreditToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :credit, :string
  end

  def self.down
    remove_column :pictures, :credit
  end
end
