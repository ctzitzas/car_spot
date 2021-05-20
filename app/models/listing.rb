class Listing < ApplicationRecord
  belongs_to :user
  has_one :transaction, dependent: :destroy
  validates :type, :status, :price, :year, :make, :model, :roadworhty, :condition, :description, presence: true 
end
