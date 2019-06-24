class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image_url
  validates :encrypted_password, length: { minimum: 6 }
  validates :email, uniqueness: true
end
