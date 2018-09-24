require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@shop = shops(:shoppers)
  	@food = orders(:food)
  end
  
  test "index should list orders from only the right shop" do
  	get shop_orders_path(@shop)
  	assert_response :success
  	assert_not json.empty?
  	assert_equal @shop.orders.count, json.length
  	assert_not_equal Order.count, json.length
  end
  
  test "create should add an order" do
  	assert_difference 'Order.count', 1 do
  		post shop_orders_path(@shop), params: { comment: "Valid order"}
  	end
  	assert_response :success
  	assert_not json.empty?
  	assert_equal "Valid order", json["comment"]
  	assert_equal "0.0", json["cost"]
  end
  
  test "order cost should be ignored" do
  	post shop_orders_path(@shop), params: { cost: 10.99 }
  	assert_response :success
  	assert_equal "0.0", json["cost"]
  end
  
  test "update should update an order" do
    assert_changes "@food.reload.comment" do
  	  patch shop_order_path(@shop, @food), params: { comment: "Valid comment" }
  	end
  	assert_response :success
  	assert_equal "Valid comment", @food.reload.comment
  end
  
  test "delete should delete an order" do
  	assert_difference 'Order.count', -1 do
  		delete shop_order_path(@shop, @food)
  	end
  	assert_response :success
  end
  
end
