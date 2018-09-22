require 'test_helper'

class ShopsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@shop = shops(:shoppers)
  end
  
  test "index should list Shops" do
  	get shops_path
  	assert_response :success
  	assert_not json.empty?
  end
  
end
