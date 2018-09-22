class Product < ApplicationRecord

	belongs_to :shop
	has_many :line_items
	has_many :orders, through: :line_items
	
	validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validate :price_must_be_dollar_amount
	
	private
	
		# Validates that the price is a valid dollar amount
		def price_must_be_dollar_amount
			if price
				cents = price * 100
				unless cents.remainder(1).zero?
					errors.add(:price, "is not a valid dollar amount")
				end
			end
		end
end