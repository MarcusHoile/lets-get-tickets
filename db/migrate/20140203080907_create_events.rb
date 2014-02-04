class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :when
      t.string :what
      t.text :description
      t.string :where
      t.datetime :on_sale
      t.integer :price
      t.references :user, index: true

      t.timestamps
    end
  end
end
