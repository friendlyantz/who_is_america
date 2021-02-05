class Location < ApplicationRecord
  has_many :politicians
  
  has_many :child_locations, class_name: "Location", foreign_key: "parent_location_id"
  belongs_to :parent_location, class_name: "Location", optional: true

  enum location_type: [:country, :state, :city]

end
