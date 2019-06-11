class User < ApplicationRecord
	# validates :title, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :postal_code, length: { is: 7 }
  validates :phone_number, length: { is: 11 }
  validates :encrypted_password, length: { minimum: 6 }
  has_many :likes, dependent: :destroy
end