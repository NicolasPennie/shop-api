require 'test_helper'

class LineItemsTest < ActiveSupport::TestCase
	
	def setup
		@shop = shops(:shoppers)
		@bread = products(:bread)
		@order = orders(:food)
	end
	
	test "valid line item" do
		assert @bread.line_items.new(order_id: @order.id, count: 1).valid?
		assert @order.line_items.new(product_id: @bread.id, count: 1).valid?
	end
	
	test "product and order should exist" do
		assert_not @bread.line_items.new(count: 1).valid?
		assert_not @order.line_items.new(count: 1).valid?
	end
	
	test "count should exist" do
		assert_not @bread.line_items.new(order_id: @order.id).valid?
	end
	
	test "count should be an integer greater than zero" do
		assert_not @bread.line_items.new(order_id: @order.id, count: "str").valid?
	  assert_not @bread.line_items.new(order_id: @order.id, count: 0).valid?
		assert_not @bread.line_items.new(order_id: @order.id, count: 3.5).valid?
	end
	
end