class DropGuestsGuestlistsTickets < ActiveRecord::Migration
  def change
  	drop_table("guestlists")
  	drop_table("tickets")
  	drop_table("guests")
  end
end
