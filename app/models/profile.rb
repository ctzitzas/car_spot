class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validates :first_name, :last_name, :type, presence: true
end
