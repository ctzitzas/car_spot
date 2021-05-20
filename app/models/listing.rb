class Listing < ApplicationRecord
  belongs_to :user
  validates :type, :status, :price, :year, :make, :model, :roadworhty, :condition, :description, presence: true 
end
