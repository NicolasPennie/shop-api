require 'test_helper'

class ShopsTest < ActiveSupport::TestCase

  test "valid shop" do
    assert Shop.new(name: "Valid").valid?
  end
  
  test "shop name should exist" do
    assert_not Shop.new().valid?
    assert_not Shop.new(name: "   ").valid?
  end
  
  test "shop name is not longer than 50 chars" do
    assert_not Shop.new(name: ("a" * 51)).valid?
  end
  
  test "shop name should be unique" do
    assert_not Shop.new(name: "Shoppers").valid?
  end
end