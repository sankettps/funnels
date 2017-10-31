class FrontendController < ApplicationController
	include FrontendHelper
	def get_upsell_detail
	 	@shop = Shop.find_by_shopify_domain(params[:shop_id])
	 	if @shop.present?
	 		# @funnel = @shop.funnels.find_by(is_active: true)
	 		@filter_product = FilterShopProduct.find_by(product_id: params[:product_id])
	 		@funnel = @filter_product.funnels.find_by(is_active: true) if @filter_product

	 		@shop_url ="https://#{ShopifyApp.configuration.api_key}:#{@shop.shopify_token}@#{@shop.shopify_domain}/admin/"
  		# @shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
    	ShopifyAPI::Base.site = @shop_url
			puts "<======funnel========#{@funnel.inspect}===============>"
    	if @funnel
    		@up_product_img_array = {}
		 		@up_product = ShopifyAPI::Product.find(@funnel.up_product.product_id)
		 		arr_options = []
				@up_product.options.each {|option| arr_options << option.name}
				@up_product.options = arr_options
    		@up_variant = @up_product.variants.first
		 		@up_product.images.each do |img|
		 		if img.variant_ids.present?
		 			img.variant_ids.each do |vid|
		 				@up_product_img_array[vid] = img.src
		 			end
		 		end
		 	end
		 		@down_product = ShopifyAPI::Product.find(@funnel.down_product.product_id)
    		@down_variant = @down_product.variants.first
		 		puts "<======test product========#{@up_product.inspect}===============>"
		 		# modal_html
		 		@html = modal_html2
		 		# @funnel
		 		@response = {data: @html}
		 	else
		 		puts "no funnel=========================="
	 			@response = {data: ''}
		 	end
	 	else
		 		puts "no shop=========================="
	 		@response = {data: ''}
	 	end
	 	render json: @response
		# $.getScript( "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js", function( ) {
  #     $("#test").click(function() {
		# 		console.log(typeof $().modal == 'function')
  #       $('#myModal').modal('show');
		# 	});
  # 	})
	end

	def funnel_product_purchased
		funnel_products = params[:funnel_products].split(',')
		upsell_products = params[:upsell_products].split(',')
		downsell_products = params[:downsell_products].split(',')
		funnel_products.each do |funnel_product|
			
		end
	end
	def test
		@shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
  	ShopifyAPI::Base.site = @shop_url
	 	puts "<======funnel========#{@funnel.inspect}===============>"
	 	@up_product = ShopifyAPI::Product.find(10941215180)
	 	puts "******************************"
	 	puts @up_product.to_json
	 	@images = @up_product.images
	 	@img_array = {}
	 	@variants_array = {}
	 				# render json: @up_product.variants and return

	 	@up_product.images.each do |img|
	 		if img.variant_ids.present?
	 			img.variant_ids.each do |vid|
	 				@img_array[vid] = img.src
	 			end
	 		end
	 	end
	 	@up_product.variants.each do |variant|
	 		@variants_array[variant.title] = [variant.id,variant.price,@img_array[variant.id]]
	 	end
	 	render json: @variants_array and return
	 	@html = '';
	 	@up_product.options.each do |option|
	 		@html += "<label>#{option.name}</label><select>" 
	 		option.values.each do |oval|
	 			@html += "<option value='#{oval}'>#{oval}</option>";
	 		end
	 		@html += "</select>";
	 	end
	 		render html: @html.html_safe and return
	end

	def getupsellproduct
	 	@shop = Shop.first

			# @shop_url ="https://#{ShopifyApp.configuration.api_key}:#{@shop.shopify_token}@#{@shop.shopify_domain}/admin/"
  	# 	puts @shop_url
  		@shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
    	ShopifyAPI::Base.site = @shop_url
		 	@up_product = ShopifyAPI::Product.find(10945801356)
		 	render json: @up_product
	end
end
