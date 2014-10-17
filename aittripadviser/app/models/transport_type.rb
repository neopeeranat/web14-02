class TransportType < ActiveRecord::Base
  set_primary_key :typeid
  has_many :directions
end
