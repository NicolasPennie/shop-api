class ProductsController < ApplicationController
	before_action :find_shop
	before_action :find_product, only: [:show, :update, :destroy]
	
	# GET /shops/:id/products
	def index
		@products = @shop.products.all
		json_response(@products)
	end
	
	# POST /shops/:id/products
	def create
		@product = @shop.products.create!(product_params)
		json_response(@product, :created)
	end
	
	# GET /shops/:id/products/:id
	def show
		json_response(@product)
	end
	
	# PUT /shops/:id/products/:id
	def update
		@product.update!(product_params)
		head :no_content
	end
	
	# DELETE /shops/:id/products/:id
	def destroy
		@product.destroy!
		head :no_content
	end
	
	private
	
		def product_params
			params.permit(:name, :price)
		end
		
		def find_shop
			@shop = Shop.find(params[:shop_id])
		end
		
		def find_product
			@product = @shop.products.find(params[:id])
		end
end
