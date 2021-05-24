class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validates :first_name, :last_name, :user_type, :location, presence: true
  enum user_type: { enthusiast: 1, hobbyist: 2, collector: 3, dealer: 4 }
end
