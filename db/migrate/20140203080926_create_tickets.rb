class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.datetime :on_sale
      t.integer :price
      t.boolean :purchased
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
