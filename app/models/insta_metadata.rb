class InstaMetadata < ActiveRecord::Base
  establish_connection()
  self.table_name = 'insta_metadata'
  has_one :image_info
end
