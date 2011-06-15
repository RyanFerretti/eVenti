class AddEmailConfirmationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_confirmation, :string
  end

  def self.down
    remove_column :users, :email_confirmation
  end
end
