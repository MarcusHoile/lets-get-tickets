class RenameEventsToPlans < ActiveRecord::Migration
  def up
    rename_table :events, :plans
  end

  def down
    rename_table :plans, :events
  end
end
