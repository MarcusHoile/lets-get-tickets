class AddDemoToEvent < ActiveRecord::Migration
  def change
    add_column :events, :demo, :boolean
  end
end
