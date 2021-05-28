class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_one :profile, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :profile
  validates :username, presence: true, uniqueness: true
  attribute :admin, :boolean, default: false
end
