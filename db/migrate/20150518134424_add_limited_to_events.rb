class AddLimitedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :limited, :integer
  end
end
