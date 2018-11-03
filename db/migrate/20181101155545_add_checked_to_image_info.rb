class AddCheckedToImageInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :image_info, :checked, :integer , default: 0
  end
end
