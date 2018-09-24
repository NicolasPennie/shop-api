require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@shop = shops(:shoppers)
  	@bread = products(:bread)
  end
  
  test "index should list products from only the right shop" do
  	get shop_products_path(@shop)
  	assert_response :success
  	assert_not json.empty?
  	assert_equal @shop.products.count, json.length
  	assert_not_equal Product.count, json.length
  end
  
  test "create should add a product" do
  	assert_difference 'Product.count', 1 do
  		post shop_products_path(@shop), params: { name: "Valid name",
  		                                          price: 10.0 }
  	end
  	assert_response :success
  	assert_not json.empty?
  	assert_equal "Valid name", json["name"]
  end
  
  test "failed post request should return error" do
  	post shop_products_path(@shop), params: { name: "" }
  	assert_response :unprocessable_entity
  	assert_match "Name can't be blank", @response.body
  end
  
  test "show should find a product" do
  	get shop_product_path(@shop, @bread)
  	assert_response :success
  	assert_not json.empty?
  	assert_equal @bread.name, json["name"]
  end
  
  test "failed get request should return error" do
  	# shop does not exist
  	get shop_path(@shop) + '/products/55'
  	assert_response :not_found
  	assert_match "Couldn't find", @response.body
  end
  
  test "update should update a product" do
  	patch shop_product_path(@shop, @bread), params: { price: 7.7 }
  	assert_response :success
  	assert_equal 7.7, @bread.reload.price
  end
  
  test "failed update request should return error" do
  	patch shop_product_path(@shop, @bread), params: { price: "string" }
  	assert_response :unprocessable_entity
  	assert_match "Price is not a number", @response.body
  end
  
  test "delete should delete a product" do
  	assert_difference 'Product.count', -1 do
  		delete shop_product_path(@shop, @bread)
  	end
  	assert_response :success
  end
end
