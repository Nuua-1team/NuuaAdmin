class CreateShowLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :show_logs do |t|
      t.text :log
      t.string :time

      t.timestamps
    end
  end
end
