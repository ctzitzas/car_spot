class Listing < ApplicationRecord
  belongs_to :user
  has_one :purchase
  validates :ad_type, :status, :price, :year, :make, :model, :roadworthy, :condition, :description, presence: true
  enum ad_type: { selling: 1, wanted: 2, }
  enum status: { active: 1, inactive: 2, sold: 3 }
  enum roadworthy: { supplied: 1, pending: 2, unavailable: 3 }
  enum condition: { poor: 1, good: 2, excellent: 3, pristine: 4 }
end
