class ImageInfo < ActiveRecord::Base
  establish_connection()
  self.table_name = 'image_info'
  has_many :simlists
  def self.change_to_bool(status)
    if status==2
      return true
    end
    return false
  end

end
