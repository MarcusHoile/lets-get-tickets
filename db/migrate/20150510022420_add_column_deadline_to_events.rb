class AddColumnDeadlineToEvents < ActiveRecord::Migration
  def up
    add_column :events, :deadline, :datetime
    add_column :events, :when, :datetime
    remove_column :events, :event_when, :datetime
    remove_column :events, :on_sale, :datetime
  end
end
