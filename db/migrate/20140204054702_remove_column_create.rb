class RemoveColumnCreate < ActiveRecord::Migration
  def change
  	remove_column :friendships, :create
  	remove_column :friendships, :destroy
  end
end
