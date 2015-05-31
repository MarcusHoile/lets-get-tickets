class RemoveMessageFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :message_id
  end
end
