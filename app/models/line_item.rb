class LineItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	
	validates :cost, presence: true
	validates :count, presence: true
end
