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
  
  test "destroy shop should delete associated products, orders, and line items" do
    Shop.all.each do |shop|
     shop.destroy
    end
    assert Shop.count.zero?
    assert Product.count.zero?
    assert Order.count.zero?
    assert LineItem.count.zero?
  end
  
  test "destroy product should delete associated line items" do
    assert_difference [->{Product.count}, ->{LineItem.count}], -1 do
      @bread.destroy
    end
  end
  
  test "destroy order should delete associated line items" do
    count_before_destroy = LineItem.count
    assert_difference 'Order.count', -1 do
      @order.destroy
    end
    assert LineItem.count < count_before_destroy
  end
end