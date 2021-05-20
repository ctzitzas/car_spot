class Location < ApplicationRecord
  validates :state, :region, presence: true
end
