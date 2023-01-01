class Profile < ApplicationRecord
	validates :name, presence: true, length: { in: 2..20 }

	belongs_to :user
end
