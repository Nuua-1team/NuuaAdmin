class AddDateToSimlists < ActiveRecord::Migration[5.2]
  def change
    add_column :simlists, :created_at, :datetime
  end
end
