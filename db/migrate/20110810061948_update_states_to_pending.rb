class UpdateStatesToPending < ActiveRecord::Migration
  def self.up
    Member.update_all "state = 'pending'", "state is null"
  end

  def self.down
  end
end
