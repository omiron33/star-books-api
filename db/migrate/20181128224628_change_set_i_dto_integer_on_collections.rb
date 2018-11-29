class ChangeSetIDtoIntegerOnCollections < ActiveRecord::Migration[5.2]
  def change
    change_column :collections, :set_id, :integer
  end
end
