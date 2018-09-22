class Shop < ApplicationRecord
	has_many :orders, dependent: :destroy
	has_many :products, dependent: :destroy
	
	validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
