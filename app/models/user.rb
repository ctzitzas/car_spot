class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings, dependent: :destroy
  has_many :transactions, dependent: :destroy
  validates :username, presence: true, uniqueness: true, format: { with: /\A\w+\z/, message: 'Username can only have alphanumeric characters' }
end
