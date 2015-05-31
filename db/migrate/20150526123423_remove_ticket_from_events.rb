class RemoveTicketFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :ticket, :string
  end
end
