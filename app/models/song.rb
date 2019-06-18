class Song < ApplicationRecord
	belongs_to :disk

	validates :song, presence: true
	validates :disk_id, presence: true
end
