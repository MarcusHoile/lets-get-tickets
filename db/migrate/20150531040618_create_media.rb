class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :link
      t.string :uid, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
