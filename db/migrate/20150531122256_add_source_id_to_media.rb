class AddSourceIdToMedia < ActiveRecord::Migration
  def change
    add_column :media, :source_id, :string
  end
end
