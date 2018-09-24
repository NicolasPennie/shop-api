### Shoppers ###
shoppers = Shop.create!(name: "Shoppers")

# Products
bread = shoppers.products.create!(name: "Bread", price: 5.50)
apple = shoppers.products.create!(name: "Apple", price: 0.75)
eggs = shoppers.products.create!(name: "Eggs", price: 1.99)
pants = shoppers.products.create!(name: "Pants", price: 49.50)
shoes = shoppers.products.create!(name: "Shoes", price: 35.00)
bag = shoppers.products.create!(name: "Bag", price: 1.00)

# Food Order
food = shoppers.orders.create!(comment: "Food order")
food.line_items.create!(product_id: bread.id, 
												count: 1, 
												cost: bread.price)
food.line_items.create!(product_id: apple.id, 
												count: 3, 
												cost: (3 * apple.price))
food.line_items.create!(product_id: eggs.id, 
												count: 2, 
												cost: (2 * eggs.price))
food.line_items.create!(product_id: bag.id, 
												count: 1, 
												cost: bag.price)
food_sum = food.line_items.pluck(:cost).sum
food.update_attribute(:cost, food_sum)

# Clothes Order
clothes = shoppers.orders.create!(comment: "Clothes order")
clothes.line_items.create!(product_id: pants.id, 
												count: 2, 
												cost: (2 * pants.price))
clothes.line_items.create!(product_id: shoes.id, 
												count: 1, 
												cost: shoes.price)
clothes.line_items.create!(product_id: bag.id, 
												count: 1, 
												cost: bag.price)
clothes_sum = clothes.line_items.pluck(:cost).sum
clothes.update_attribute(:cost, clothes_sum)

#
### Fake Shop ###
#

fake_shop = Shop.create!(name: Faker::Company.name)
fruit_order = fake_shop.orders.create!(comment: "Fruit order")
vege_order = fake_shop.orders.create!(comment: "Vegetable order")

# Fruits
5.times do
	product = fake_shop.products.create!(name: Faker::Food.fruits, 
																			 price: rand(10) + 1)
	order_count = rand(5) + 1
	fruit_order.line_items.create!(product_id: product.id, 
																 count: order_count, 
																 cost: order_count * product.price)
end
fruit_sum = fruit_order.line_items.pluck(:cost).sum
fruit_order.update_attribute(:cost, fruit_sum)
	

# Veges
8.times do
	product = fake_shop.products.create!(name: Faker::Food.vegetables, 
																			 price: rand(10) + 1)
	order_count = rand(5) + 1
	vege_order.line_items.create!(product_id: product.id, 
															  count: order_count, 
																cost: order_count * product.price)
end
vege_sum = vege_order.line_items.pluck(:cost).sum
vege_order.update_attribute(:cost, vege_sum)


