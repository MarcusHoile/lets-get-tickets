class AddColumnsToInvites < ActiveRecord::Migration
  def self.up
    add_column :invites, :reason, :string
  end
  def self.down
    remove_column :invites, :reason
  end
end
