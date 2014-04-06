class RenameColumnEvents < ActiveRecord::Migration
  def change
  	rename_column :events, :when, :event_when
  end
end
