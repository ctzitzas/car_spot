class Profile < ApplicationRecord
  belongs_to :user
  has_one :user
  has_one :location
  validates :first_name, :last_name, :status, presence: true
  enum status: { enthusiast: 1, hobbyist: 2, collector: 3, dealer: 4 }
end
