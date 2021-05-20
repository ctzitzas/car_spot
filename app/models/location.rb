class Location < ApplicationRecord
  validates :state, :region, presence: true
  has_many :profiles
end
