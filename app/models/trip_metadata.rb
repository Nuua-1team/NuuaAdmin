class TripMetadata < ActiveRecord::Base
  establish_connection()
  self.table_name = 'trip_metadata'
end
