class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_one :location
  has_one :user
  validates :first_name, :last_name, :type, presence: true
  enumm type: { enthusiast: 1, hobbyist: 2, collector: 3, dealer: 4 }
end
