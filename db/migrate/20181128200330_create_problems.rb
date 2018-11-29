class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.string :description
      t.references :collection, foreign_key: true

      t.timestamps
    end
  end
end
