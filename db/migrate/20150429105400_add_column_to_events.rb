class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :booked, :boolean, default: false
  end
end
