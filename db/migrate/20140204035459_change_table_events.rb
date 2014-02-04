class ChangeTableEvents < ActiveRecord::Migration
  def change
  	add_column :events, :on_sale, :datetime
  	add_column :events, :price, :integer
  end
end
