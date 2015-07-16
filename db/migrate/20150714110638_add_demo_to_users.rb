class AddDemoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :demo, :boolean
  end

  def self.down
    remove_column :users, :demo
  end
end
