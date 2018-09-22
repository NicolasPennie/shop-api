require 'test_helper'

class OrdersTest < ActiveSupport::TestCase
	
	def setup
		@shop = shops(:shoppers)
	end
	
	test "valid order" do
		assert @shop.orders.new().valid?
		assert @shop.orders.new(comment: "Valid order").valid?
	end

  test "shop should exist" do
    assert_not Order.new().valid?
    assert_not Order.new(shop_id: 99).valid?
  end
end