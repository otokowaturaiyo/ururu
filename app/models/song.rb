class Song < ApplicationRecord
	belongs_to :disk

	validates :song, presence: true
end
