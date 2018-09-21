require 'test_helper'

class ModelsTest < ActiveSupport::TestCase
  def setup
    @shop = shops(:shoppers)
    @bread = products(:bread)
    @order = orders(:food)
  end
  
  test "shop model associates correctly" do
    assert_equal @bread, @shop.products.find_by(name: "Bread")
    assert_equal @order, @shop.orders.find_by(comment: "Food order")
  end
  
  test "line orders associate correctly" do
    assert_equal @bread.line_items.first, @order.line_items.first
  end
  
  test "orders and products associate through line orders" do
    assert_equal @bread, @order.products.find_by(name: "Bread")
    assert_equal @order, @bread.orders.first
  end
end