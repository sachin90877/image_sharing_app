class Album < ApplicationRecord
	validates :name, presence: true, length: { in: 2..20 }
	validates_length_of :photos, maximum: 24

	belongs_to :user
	has_many :photos, dependent: :destroy
end
