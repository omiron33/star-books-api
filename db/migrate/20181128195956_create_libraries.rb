class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.integer :timestamp

      t.timestamps
    end
  end
end
