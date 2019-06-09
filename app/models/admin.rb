class Admin < ApplicationRecord
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :validatable
	attachment :profile_image_url
end
