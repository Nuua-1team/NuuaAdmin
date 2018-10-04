class ImageInfo < ActiveRecord::Base
  establish_connection()
  self.table_name = 'image_info'

  def self.change_to_bool(status)
    if status==2
      return true
    end
    return false
  end

end
