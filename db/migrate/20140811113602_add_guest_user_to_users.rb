class AddGuestUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :guest_user, :boolean
  end
end
