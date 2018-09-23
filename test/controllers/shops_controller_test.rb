require 'test_helper'

class ShopsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@shop = shops(:shoppers)
  end
  
  test "index should list Shops" do
  	get shops_path
  	assert_response :success
  	assert_not json.empty?
  	assert_equal Shop.count, json.length
  end
  
  test "create should add a Shop" do
  	assert_difference 'Shop.count', 1 do
  		post shops_path, params: { name: "Valid name" }
  	end
  	assert_response :success
  	assert_not json.empty?
  	assert_equal "Valid name", json["name"]
  end
  
  test "failed post request should return error" do
  	# shop does not exist
  	post '/shops', params: { name: "" }
  	assert_response :unprocessable_entity
  	assert_match "Name can't be blank", @response.body
  end
  
  test "show should find a shop" do
  	get shop_path(@shop)
  	assert_response :success
  	assert_not json.empty?
  	assert_equal @shop.name, json["name"]
  end
  
  test "failed get request should return error" do
  	# shop does not exist
  	get '/shops/55'
  	assert_response :not_found
  	assert_match "Couldn't find", @response.body
  end
  
  test "update should update a shop" do
  	patch shop_path(@shop), params: { name: "New name" }
  	assert_response :success
  end
  
  test "failed update request should return error" do
  	patch shop_path(@shop), params: { name: "  "}
  	assert_response :unprocessable_entity
  	assert_match "Name can't be blank", @response.body
  end
  
  test "delete should delete a shop" do
  	assert_difference 'Shop.count', -1 do
  		delete shop_path(@shop)
  	end
  	assert_response :success
  end
end
