class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :rsvp, default: "Undecided"
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
