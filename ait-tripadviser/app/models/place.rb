class Place < ActiveRecord::Base
  has_many :departures,  :foreign_key => 'origin_id',
                       :class_name => 'Direction',
                       :dependent => :destroy
  has_many :destinations,     :through => :departures
  has_many :arrivals,   :foreign_key => 'destination_id',
                       :class_name => 'Direction',
                       :dependent => :destroy
  has_many :origins, :through => :arrivals
end
