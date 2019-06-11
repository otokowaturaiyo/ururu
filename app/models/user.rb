class User < ApplicationRecord
	attachment :profile_image_url
	# validates :title, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :kanji_lastname, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kanji_firstname, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kana_lastname, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :kana_lastname, format: { with: /\A[ァ-ヶー－]+\z/ }
end
