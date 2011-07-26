class RemoveRoles < ActiveRecord::Migration
  def self.up
    drop_table :roles_users
    drop_table :roles
  end

  def self.down
    raise IrreversibleMigration
  end
end
