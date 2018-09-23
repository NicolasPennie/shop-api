class ProductsController < ApplicationController
	before_action :find_shop
	before_action :find_product, only: [:show, :update, :destroy]
	
	# GET /products
	def index
		@products = @shop.products.all
		json_response(@products)
	end
	
	# POST /products
	def create
		@product = @shop.products.create!(product_params)
		json_response(@product, :created)
	end
	
	# GET /products/:id
	def show
		json_response(@product)
	end
	
	# PUT /products/:id
	def update
		@product.update!(product_params)
		head :no_content
	end
	
	# DELETE /products/:id
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
