class AddColumnTicketsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :ticket, :boolean, default: false
  end
  def self.down
    remove_column :events, :ticket
  end
end
