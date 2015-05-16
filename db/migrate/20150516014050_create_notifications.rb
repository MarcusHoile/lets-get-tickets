class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :active, default: true
      t.references :user
      t.references :event
      t.references :message

      t.timestamps
    end
  end
end
