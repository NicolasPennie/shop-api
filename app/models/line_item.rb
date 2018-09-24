class LineItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	after_destroy :update_order_cost
	
	validates :count, numericality: { only_integer: true,
																		greater_than: 0 }
	
	def update_order_cost
			order = self.order
			sum = order.line_items.pluck(:cost).sum
			order.update_attribute(:cost, sum)
	end
end
