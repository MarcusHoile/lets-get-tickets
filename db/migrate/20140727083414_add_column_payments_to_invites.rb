class AddColumnPaymentsToInvites < ActiveRecord::Migration
  def self.up
    add_column :invites, :payment, :boolean, default: false
  end
  def self.down
    remove_column :invites, :payment
  end
end
