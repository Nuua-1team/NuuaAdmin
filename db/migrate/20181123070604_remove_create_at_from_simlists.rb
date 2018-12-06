class RemoveCreateAtFromSimlists < ActiveRecord::Migration[5.2]
  def change
    remove_column :simlists, :created_at, :datetime
    remove_column :simlists, :updated_at, :datetime
  end
end
