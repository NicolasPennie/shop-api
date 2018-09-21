# Shops
shop = Shop.create!(name: "Shoppers")

# Products
bread = shop.products.create!(name: "Bread", price: 5.50)
apple = shop.products.create!(name: "Apple", price: 0.75)
eggs = shop.products.create!(name: "Eggs", price: 1.99)
pants = shop.products.create!(name: "Pants", price: 49.50)
shoes = shop.products.create!(name: "Shoes", price: 35.00)

# Food Order
food = shop.orders.create!(comment: "Food order")
food.line_items.create!(product_id: bread.id, 
												count: 1, 
												cost: bread.price)
food.line_items.create!(product_id: apple.id, 
												count: 3, 
												cost: (3 * apple.price))
food.line_items.create!(product_id: eggs.id, 
												count: 2, 
												cost: (2 * eggs.price))
food_sum = food.line_items.pluck(:cost).sum
food.update_attribute(:cost, food_sum)

# Clothes Order
clothes = shop.orders.create!(comment: "Clothes order")
clothes.line_items.create!(product_id: pants.id, 
												count: 2, 
												cost: (2 * pants.price))
clothes.line_items.create!(product_id: shoes.id, 
												count: 1, 
												cost: shoes.price)
clothes_sum = clothes.line_items.pluck(:cost).sum
clothes.update_attribute(:cost, clothes_sum)
			

