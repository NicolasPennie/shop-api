require 'test_helper'

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@shop = shops(:shoppers)
  	@bread = products(:bread)
  	@food = orders(:food)
  	@item = line_items(:bread)
  end
  
  test "index should list items from only the right order" do
  	get shop_order_line_items_path(@shop, @food)
  	assert_response :success
  	assert_not json.empty?
  	assert_equal @food.line_items.count, json.length
  	assert_not_equal LineItem.count, json.length
  end
  
  test "create should add a line item" do
  	assert_difference 'LineItem.count', 1 do
  		post shop_order_line_items_path(@shop, @food), 
  		                                params: { product_id: @bread.id,
  		                                          count: 3 }
  	end
  	assert_response :success
  	assert_not json.empty?
  	assert_equal 3, json["count"]
  	assert_equal (3 * @bread.price), json["cost"].to_d
  end
  
  test "order cost should change when line item is added" do
    assert_difference '@food.reload.cost', @bread.price do
  		post shop_order_line_items_path(@shop, @food), 
  		                                params: { product_id: @bread.id,
  		                                          count: 1 }
    end
  end
  
  test "failed post request should return error" do
  	post shop_order_line_items_path(@shop, @food),
  	                                params: { product_id: "Invalid ID" }
  	assert_response :unprocessable_entity
  	assert_match "Product must exist", @response.body
  end
  
  test "show should find a line item" do
  	get shop_order_line_item_path(@shop, @food, @item)
  	assert_response :success
  	assert_not json.empty?
  	assert_equal @item.product.id, json["product_id"]
  	assert_equal @item.count, json["count"]
  end
  
  test "failed get request should return error" do
  	# shop does not exist
  	get shop_order_path(@shop, @food) + '/line_items/55'
  	assert_response :not_found
  	assert_match "Couldn't find", @response.body
  end
  
  test "update should change line item" do
    # increase bread count from 5 to 6
    assert_difference '@food.reload.cost', @bread.price do
  	  patch shop_order_line_item_path(@shop, @food, @item), params: { count: 6 }
  	end
  	assert_response :success
  	assert_equal 6, @item.reload.count
  end
  
  test "failed update request should return error" do
  	patch shop_product_path(@shop, @bread), params: { price: "string" }
  	assert_response :unprocessable_entity
  	assert_match "Price is not a number", @response.body
  end
  
  test "delete should delete a line item" do
  	assert_difference 'LineItem.count', -1 do
  		delete shop_order_line_item_path(@shop, @food, @item)
  	end
  	assert_response :success
  	# Order cost should update
  	assert_equal (@food.cost - @item.cost),  @food.reload.cost
  end
end
