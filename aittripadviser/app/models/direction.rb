class Direction < ActiveRecord::Base
 belongs_to :place
 belongs_to :transport_type
 set_primary_key :placeid, :typeid, :destinationid
end
