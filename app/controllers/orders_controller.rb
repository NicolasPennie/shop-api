class OrdersController < ApplicationController
	before_action :find_shop
	before_action :find_order, only: [:show, :update, :destroy]
	
	# GET /shops/:id/orders
	def index
		@orders = @shop.orders.all
		json_response(@orders)
	end
	
	# POST /shops/:id/orders
	def create
		@order = @shop.orders.create!(order_params.merge({cost: 0}))
		json_response(@order, :created)
	end
	
	# GET /shops/:id/orders/:id
	def show
		json_response(@order)
	end
	
	# PUT /shops/:id/orders/:id
	def update
		@order.update!(order_params)
		head :no_content
	end
	
	# DELETE /shops/:id/orders/:id
	def destroy
		@order.destroy!
		head :no_content
	end
	
	private
	
		def order_params
			params.permit(:comment)
		end
		
		def find_shop
			@shop = Shop.find(params[:shop_id])
		end
		
		def find_order
			@order = @shop.orders.find(params[:id])
		end
end
