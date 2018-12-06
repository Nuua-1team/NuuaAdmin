class CreateSimlists < ActiveRecord::Migration[5.2]
  def change
    create_table :simlists do |t|
      t.float :sim
      t.integer :is_positive
      t.references :image_info#, foreign_key: true

      t.timestamps
    end
  end
end
