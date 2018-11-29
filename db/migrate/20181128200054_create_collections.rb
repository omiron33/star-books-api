class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :condition
      t.string :status
      t.references :library, foreign_key: true

      t.timestamps
    end
  end
end
