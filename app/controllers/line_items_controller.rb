class LineItemsController < ApplicationController
	before_action :find_data
	before_action :find_line_item, only: [:show, :update, :destroy]
	after_action :compute_order_cost, only: [:create, :update, :destroy]
	
	# GET /shops/:id/orders/:id/line_items
	def index
		@line_items = @order.line_items.all
		json_response(@line_items)
	end
	
	# POST /shops/:id/orders/:id/line_items
	def create
		@line_item = @order.line_items.create!(line_item_params)
		compute_line_cost
		json_response(@line_item, :created)
	end
	
	# GET /shops/:id/orders/:id/line_items/:id
	def show
		json_response(@line_item)
	end
	
	# PUT /shops/:id/orders/:id/line_items/:id
	def update
		@line_item.update!(line_item_params)
		compute_line_cost
		head :no_content
	end
	
	# DELETE /shops/:id/orders/:id/line_items/:id
	def destroy
		@line_item.destroy!
		head :no_content
	end
	
	private
	
		def line_item_params
			params.permit(:product_id, :count)
		end
		
		def find_data
			@shop = Shop.find(params[:shop_id])
			@order = @shop.orders.find(params[:order_id])
		end
		
		def find_line_item
			@line_item = @order.line_items.find(params[:id])
		end
		
		def compute_line_cost
			cost = @line_item.product.price * @line_item.count
			@line_item.update_attribute(:cost, cost)
		end
		
		def compute_order_cost
			# puts @order.line_items.pluck(:cost)
			order_sum = @order.line_items.pluck(:cost).sum
			@order.update_attribute(:cost, order_sum)
		end
end
