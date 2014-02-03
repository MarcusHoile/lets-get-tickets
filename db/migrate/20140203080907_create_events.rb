class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :when
      t.string :what
      t.text :description
      t.string :where
      t.references :user, index: true

      t.timestamps
    end
  end
end
