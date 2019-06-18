class Destination < ApplicationRecord

  validates :postal_code, length: { is: 7 }
  validates :phone_number, length: { is: 11 }
  validates :name, :destination_address, presence: true


  belongs_to :user


end


