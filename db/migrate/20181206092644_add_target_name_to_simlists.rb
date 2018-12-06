class AddTargetNameToSimlists < ActiveRecord::Migration[5.2]
  def change
    add_column :simlists, :target_name, :string
  end
end
