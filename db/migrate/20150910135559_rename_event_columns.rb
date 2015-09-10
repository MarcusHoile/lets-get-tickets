class RenameEventColumns < ActiveRecord::Migration
  def up
    rename_column :invites, :event_id, :plan_id
    rename_column :media, :event_id, :plan_id
    rename_column :notifications, :event_id, :plan_id
  end

  def down
    rename_column :invites, :plan_id, :event_id
    rename_column :media, :plan_id, :event_id
    rename_column :notifications, :plan_id, :event_id
  end
end
