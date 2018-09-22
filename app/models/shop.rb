class Shop < ApplicationRecord
	has_many :orders
	has_many :products
	
	validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
