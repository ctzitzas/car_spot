class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :purchase
  has_one :profile, through: :user
  validates :ad_type, :status, :price, :year, :make, :model, :roadworthy, :condition, :description, presence: true
  attribute :status, :integer, default: 1
  enum ad_type: { selling: 1, wanted: 2, }
  enum status: { active: 1, inactive: 2, sold: 3 }
  enum roadworthy: { supplied: 1, pending: 2, unavailable: 3 }
  enum condition: { poor: 1, good: 2, excellent: 3, pristine: 4 }
  scope :for_sale, -> { where(status:1) && where(ad_type:1)}
  scope :wanted, -> { where(ad_type:2)}
end