require 'test_helper'

class ProductsTest < ActiveSupport::TestCase
	
	def setup
		@shop = shops(:shoppers)
	end
	
	test "valid product" do
		assert @shop.products.new(name: "Valid", price: 5).valid?
		assert @shop.products.new(name: "Valid", price: 5.15).valid?
		assert @shop.products.new(name: "Valid", price: 5.150).valid?
	end
	
	test "shop should exist" do
		assert_not Product.new().valid?
    assert_not Product.new(shop_id: 99).valid?
	end
	
	test "name should be unique" do
	  assert_not @shop.products.new(name: "Bread", price: 5).valid?
	end

  test "product name should exists" do
    assert_not @shop.products.new().valid?
    assert_not @shop.products.new(name: "  ", price: 5).valid?
  end
  
  test "product name is not longer than 50 characters" do
    assert_not @shop.products.new(name: ("a" * 51), price: 5).valid?
  end
  
  test "product price should be valid dollar amount" do
  	assert_not @shop.products.new(name: "Valid").valid?
  	assert_not @shop.products.new(name: "Valid", price: "string").valid?
    assert_not @shop.products.new(name: "Valid", price: 5.015).valid?
    assert_not @shop.products.new(name: "Valid", price: 0.015).valid?
    assert_not @shop.products.new(name: "Valid", price: -5.00).valid?
  end
end