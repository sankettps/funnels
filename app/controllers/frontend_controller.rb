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
		 		@up_product = ShopifyAPI::Product.find(@funnel.up_product.product_id)
    		@up_variant = @up_product.variants.first
		 		
		 		@down_product = ShopifyAPI::Product.find(@funnel.down_product.product_id)
    		@down_variant = @down_product.variants.first
		 		puts "<======test product========#{@up_product.inspect}===============>"
		 		modal_html
		 		# @html = modal_html
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
end
