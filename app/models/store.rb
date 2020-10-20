class Store < ApplicationRecord
  has_many :ratings
  validates_presence_of :lonlat, :name, :google_place_id
  validates :google_place_id, uniqueness: true

  scope :within, -> (longitude, latitude, distance_in_km = 5) {
    where(%{
          ST_Distance(lonlat, 'POINT(%f %f)') < %d
    } % [longitude, latitude, distance_in_km * 1000])
  }
end
