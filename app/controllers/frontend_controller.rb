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
    		puts "Innnnnnnnnnnnnnnnn"
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
    		@down_product_img_array = {}
		 		@down_product = ShopifyAPI::Product.find(@funnel.down_product.product_id)
    		arr_options = []
				@down_product.options.each {|option| arr_options << option.name}
				@down_product.options = arr_options
    		@down_variant = @up_product.variants.first
		 		@down_product.images.each do |img|
			 		if img.variant_ids.present?
			 			img.variant_ids.each do |vid|
			 				@down_product_img_array[vid] = img.src
			 			end
			 		end
			 	end
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
		@shop = Shop.find_by_shopify_domain(params[:shop_id])
		# funnel_product = FilterShopProduct.find_by(product_id: params[:funnel_product])
		# upsell_product = FilterShopProduct.find_by(product_id: params[:upsell_product]) if params[:upsell_product].present?
		# downsell_product = FilterShopProduct.find_by(product_id: params[:downsell_product]) if params[:downsell_product].present?
		@shop.funnel_reports.create(product_id: params[:product_id],up_product_id: params[:upsell_product],price: params[:price],hf_action: params[:hf_action]) if params[:upsell_product].present?
		@shop.funnel_reports.create(product_id: params[:product_id],down_product_id: params[:downsell_product],price: params[:price],hf_action: params[:hf_action]) if params[:downsell_product].present?
	end

	def test
		@shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
  	ShopifyAPI::Base.site = @shop_url
	 	puts "<======funnel========#{@funnel.inspect}===============>"
	 	@up_product = ShopifyAPI::Product.find(10941215180)
		 @shop = Shop.first
	 	if @shop.present?
	 		# @funnel = @shop.funnels.find_by(is_active: true)
	 		#@filter_product = FilterShopProduct.find_by(product_id: params[:product_id])
	 		#@funnel = @filter_product.funnels.find_by(is_active: true) if @filter_product

	 		# @shop_url ="https://#{ShopifyApp.configuration.api_key}:#{@shop.shopify_token}@#{@shop.shopify_domain}/admin/"
  		@shop_url = "https://fd7ec4c589db58b5652eccf59279b7d3:520600ed3d4e5b15de332ab367f25ea8@welovedrones.myshopify.com/admin/"
    	ShopifyAPI::Base.site = @shop_url
			puts "<======funnel========#{@funnel.inspect}===============>"
    	# if @funnel
    		@up_product_img_array = {}
		 		@up_product = ShopifyAPI::Product.find(10945801356)
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
    		@down_product_img_array = {}
		 		@down_product = ShopifyAPI::Product.find(10941481228)
    		arr_options = []
				@down_product.options.each {|option| arr_options << option.name}
				@down_product.options = arr_options
    		@down_variant = @up_product.variants.first
		 		@down_product.images.each do |img|
			 		if img.variant_ids.present?
			 			img.variant_ids.each do |vid|
			 				@down_product_img_array[vid] = img.src
			 			end
			 		end
			 	end
		 		@html = modal_html2
		 		render html: @html and return
		 		# @funnel
		 		@response = {data: @html}
		 	# else
		 	# 	puts "no funnel=========================="
	 		# 	@response = {data: ''}
		 	# end
	 	else
		 		puts "no shop=========================="
	 		@response = {data: ''}
	 	end
	 	render json: @response
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
