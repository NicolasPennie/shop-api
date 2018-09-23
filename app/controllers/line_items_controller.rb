class LineItemsController < ApplicationController
	before_action :find_data
	before_action :find_line_item, only: [:show, :update, :destroy]
	before_action :line_item_params, only: [:create, :update]
	
	# GET /shops/:id/orders/:id/line_items
	def index
		@line_items = @order.line_items.all
		json_response(@line_items)
	end
	
	# POST /shops/:id/orders/:id/line_items
	def create
		@line_item = @order.line_items.create!(@line_item_params, cost: @cost)
		@order.update(cost: @order.cost + @cost)
		json_response(@line_item, :created)
	end
	
	# GET /shops/:id/orders/:id/line_items/:id
	def show
		json_response(@line_item)
	end
	
	# PUT /shops/:id/orders/:id/line_items/:id
	def update
		@line_item.update!(order_params)
		head :no_content
	end
	
	# DELETE /shops/:id/orders/:id/line_items/:id
	def destroy
		@line_item.destroy!
		head :no_content
	end
	
	private
	
		def line_item_params
			@cost = params[:count] * @products.find(params[:product_id]).price
			@line_item_params = params.permit(:product_id, :count)
		end
		
		def find_data
			@shop = Shop.find(params[:shop_id])
			@products = @shop.products
			@order = @shop.orders.find(params[:order_id])
		end
		
		def find_line_item
			@line_item = @order.line_items.find(params[:id])
		end
end
