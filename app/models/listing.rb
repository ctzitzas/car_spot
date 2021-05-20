class Listing < ApplicationRecord
  belongs_to :user
  has_one :transaction, dependent: :destroy
  validates :type, :status, :price, :year, :make, :model, :roadworhty, :condition, :description, presence: true
  enum type: { selling: 1, wanted: 2, }
  enum status: { active: 1, inactive: 2, sold: 3 }
  enum roadworthy: { supplied: 1, pending: 2, none: 3 }
  enum condition: { poor: 1, good: 2, excellent: 3, pristine: 4 }
end
